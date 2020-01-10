import { LightningElement, track, api, wire } from 'lwc';  
import getRecipesList from '@salesforce/apex/ManageRecordsController.getRecipesList';  
import getRecipesCount from '@salesforce/apex/ManageRecordsController.getRecipesCount';  

import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';

export default class RecordList extends LightningElement {  
   @api _recipe;  
   @track recipes;  
   @track error;  
   @api currentpage;  
   @api pagesize;  
   @track searchKey;  
   totalpages;  
   localCurrentPage = null;  
   isSearchChangeExecuted = false; 
   @wire(CurrentPageReference) pageRef; 
   // not yet implemented  
   pageSizeOptions =  
     [  
       { label: '5', value: 5 },  
       { label: '10', value: 10 },  
       { label: '25', value: 25 },  
       { label: '50', value: 50 },  
       { label: 'All', value: '' },  
     ];  
   handleKeyChange(event) {  
     if (this.searchKey !== event.target.value) {  
       this.isSearchChangeExecuted = false;  
       this.searchKey = event.target.value;  
       this.currentpage = 1;  
     }  
   }  
   renderedCallback() {  
     // This line added to avoid duplicate/multiple executions of this code.  
     if (this.isSearchChangeExecuted && (this.localCurrentPage === this.currentpage)) {  
       return;  
     }  
     this.isSearchChangeExecuted = true;  
     this.localCurrentPage = this.currentpage;  
     getRecipesCount({ searchString: this.searchKey })  
       .then(recordsCount => {  
         this.totalrecords = recordsCount;  
         if (recordsCount !== 0 && !isNaN(recordsCount)) {  
           this.totalpages = Math.ceil(recordsCount / this.pagesize);  
           getRecipesList({ pagenumber: this.currentpage, numberOfRecords: recordsCount, pageSize: this.pagesize, searchString: this.searchKey })  
             .then(recipeList => {  
               this.recipes = recipeList;  
               this.error = undefined;  
             })  
             .catch(error => {  
               this.error = error;  
               this.recipes = undefined;  
             });  
         } else {  
           this.recipes = [];  
           this.totalpages = 1;  
           this.totalrecords = 0;  
         }  
         const event = new CustomEvent('recordsload', {  
           detail: recordsCount  
         });  
         this.dispatchEvent(event);  
       })  
       .catch(error => {  
         this.error = error;  
         this.totalrecords = undefined;  
       });  
   } 
      
    handleRecipeSelected(event) {
      // fire recipeSelected event
      fireEvent(this.pageRef, 'recipeSelected', event.target.value);
  }
 }  