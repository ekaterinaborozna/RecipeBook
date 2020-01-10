import { LightningElement, track, wire} from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

export default class Detail extends LightningElement {    
        @wire(CurrentPageReference) pageRef;
        @track ingredients;

        connectedCallback() {
            registerListener('recipeSelected', this.handleRecipeSelected, this);
        }
    
        disconnectedCallback() {
            unregisterAllListeners(this);
        }
    
        handleRecipeSelected(recipe) {
            let ingredients = recipe.RecipeIngredients__r;  
            let ingredientsDetail = [...ingredients]; 
            let allIngredientsExist = true;
            
            for (let i=0; i<ingredientsDetail.length; i++) {
              if (ingredientsDetail[i].Ingredient__r.Count__c < ingredientsDetail[i].Count__c) {
                 allIngredientsExist = false;
              }
            }

            if (allIngredientsExist) {
                ingredientsDetail.Green = 'true';                                                   
            }
            ingredientsDetail.Name = recipe.Name; 
            this.ingredients = ingredientsDetail;
        }
}
