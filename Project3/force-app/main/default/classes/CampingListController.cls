public with sharing class CampingListController {
    @AuraEnabled
    public static List<Camping_Item__c> getItems() {
        String[] fields = new String[]{'Id','Name','Packed__c','Price__c','Quantity__c'};
        Map<String,Schema.SObjectField> fieldDescriptor = Schema.SObjectType.Camping_Item__c.fields.getMap();

        for(String field : fields) {
            if(!fieldDescriptor.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }            
        }        
        return [SELECT Id,Name,Packed__c,Price__c,Quantity__c FROM Camping_Item__c];
    }


    @AuraEnabled  
    public static Camping_Item__c saveItem(Camping_Item__c item) {  
        upsert item;
        return item;
    }

}