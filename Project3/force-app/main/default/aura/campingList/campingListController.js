({
    doInit : function(component, event, helper){
        var getCampingItemListingAction = component.get('c.getItems');
        getCampingItemListingAction.setCallback(this, function(response){
            var respState = response.getState();
            if(respState == 'SUCCESS'){
                var vItems = component.get('v.items');
                vItems = response.getReturnValue();
                component.set('v.items', vItems);
            }
        });
        $A.enqueueAction(getCampingItemListingAction);
    },
    handleAddItem : function(component, event, helper){
        var newCampingItem = event.getParam('item');

        //var theItems = component.get("v.items");
        //theItems.push(newCampingItem);
        //component.set("v.items", theItems);

        //helper.createItem(component, newCampingItem);
        var saveItemAction = component.get('c.saveItem');
        saveItemAction.setParams({ 'campingItem' :  newCampingItem });

        saveItemAction.setCallback(this, function(response){
            var respState = response.getState();
            console.log(respState);
            if( respState == 'SUCCESS'){
                var theItems = component.get("v.items");
                theItems.push(response.getReturnValue());
                component.set("v.items", theItems);
            }
        });

        $A.enqueueAction(saveItemAction);
    }
})