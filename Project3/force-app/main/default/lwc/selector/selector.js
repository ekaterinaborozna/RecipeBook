/* eslint-disable no-console */
import { LightningElement, wire, api, track } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import  delSelectedCons from '@salesforce/apex/ContactController.deleteContacts';
import { createRecord } from 'lightning/uiRecordApi';
// import Contact objects and its fields reference
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import CONTACTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId';

export default class Selector extends LightningElement {
    @api recordId;
    @api relatedObjectName;
    @api value = '5';
    @track recordCreateId;
    @track draftValues = [];    
    @track record = [];
    @track bShowModal = false;
    @track currentRecordId;
    @track isEditForm = false;
    @track showLoadingSpinner = false;
    @track accountId; 
    @track contactId; 
    @track sObjectName;

    @wire(getContacts, {accId:'$recordId', relatedObjectNameParam:'$relatedObjectName', value:'$value'})    
    contact;  

    handleNameChange(event){
        this.sObjectName = event.target.value;
    } 
    // save called on click of save to insert account and contact record with LDS
    save() {
            // create related contact
            const fields_Contact = {};
            fields_Contact[CONTACTNAME_FIELD.fieldApiName] = this.sObjectName + "'s contact"; // set contact Name 
            fields_Contact[ACCOUNTID_FIELD.fieldApiName] = this.recordId;  //set account Id (parentId) in contact
            const recordInput_Contact = { apiName: CONTACT_OBJECT.objectApiName,
                                          fields : fields_Contact};
             // create contact record using Lightning Data service
              createRecord(recordInput_Contact)
                .then(contact => {
                    this.contactId = contact.id;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Contact created',
                            variant: 'success',
                        }),
                    );

                   this.sObjectName = ''; // reset name field on UI
                });
            const fields_SObject = {};
            fields_SObject.name = this.sObjectName + "'s contact"; // set contact Name same as account name
            console.log('dddddddddd-----' + fields_SObject.name);
            fields_SObject[ACCOUNTID_FIELD.fieldApiName] = this.recordId;  //set account Id (parentId) in contact
            const recordInput_SObject = { apiName: this.relatedObjectName,
                                          fields : fields_SObject};
             // create sobject !
              createRecord(recordInput_SObject)
                .then(sObject => {
                    this.sObjectId = sObject.id;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Record created',
                            variant: 'success',
                        }),
                    );
                   this.sObjectName = ''; // reset input name field on UI
                })
            .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
    }
             
get options() {
    return [
        { label: '10', value: '10' },
        { label: '5', value: '5' },
        { label: '3', value: '3' },
    ];
}

handleChange(event) {
    this.value = event.detail.value;
}

handleSave(event) {
        const recordInputs =  event.detail.draftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });
    
        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records updated',
                    variant: 'success'
                })
            );  
             // Display fresh data in the datatable
             return refreshApex(this.contact);
        }).catch(error => { // Handle error
            console.log(error);
        });
    }

    handleRowActions(event) {
        let actionName = event.detail.action.name;
        window.console.log('actionName ====> ' + actionName);
        let row = event.detail.row;
        window.console.log('row ====> ' + row);
        // eslint-disable-next-line default-case
        switch (actionName) {
            case 'record_details':
                this.viewCurrentRecord(row);
                break;
            case 'edit':
                this.editCurrentRecord(row);
                break;
            case 'delete':
                this.deleteCons(row);
                break;
        }
    }

    // view the current record details
    viewCurrentRecord(currentRow) {
        this.bShowModal = true;
        this.isEditForm = false;
        this.record = currentRow;
    }

    // closing modal box
    closeModal() {
        this.bShowModal = false;
    }

    editCurrentRecord(currentRow) {
        // open modal box
        this.bShowModal = true;
        this.isEditForm = true;
        // assign record id to the record edit form
        this.currentRecordId = currentRow.Id;
    }

    // handleing record edit form submit
    handleSubmit(event) {
        // prevending default type sumbit of record edit form
        event.preventDefault();

        // querying the record edit form and submiting fields to form
        this.template.querySelector('lightning-record-edit-form').submit(event.detail.fields);

        // closing modal
        this.bShowModal = false;

        // showing success message
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success!!',
            message: event.detail.fields.FirstName + ' '+ event.detail.fields.LastName +' Updated Successfully!!.',
            variant: 'success'
        }),);
    }

    // refreshing the datatable after record edit form success
    handleSuccess() {
        return refreshApex(this.refreshTable);
    }

    deleteCons(currentRow) {
        window.console.log('relatedObjectName ====> ' + this.relatedObjectName);
        let currentRecord = [];
        currentRecord.push(currentRow.Id);
        this.showLoadingSpinner = true;
        //String name = this.relatedObjectName;

        // calling apex class method to delete the selected contact
        delSelectedCons({lstConIds: currentRecord, relatedObjectNameParam: this.relatedObjectName})
        .then(result => {
            window.console.log('result ====> ' + result);
            this.showLoadingSpinner = false;

            // showing success message
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success!!',
                message: currentRow.FirstName + ' '+ currentRow.LastName +' Record deleted.',
                variant: 'success'
            }),);

            // refreshing table data using refresh apex
             return refreshApex(this.contact);

        })
        .catch(error => {
            window.console.log('Error ====> '+error);
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error!!', 
                message: error.message, 
                variant: 'error'
            }),);
        });
    }
}