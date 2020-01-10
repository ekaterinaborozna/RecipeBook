global class CreateOrderBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id FROM Contact';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> contactsList){
        List<Order__c> ordersList = new List<Order__c>(); 
        
        for (Contact contact :contactsList) {
            for (Integer i=0 ;i <10;i++) {
                ordersList.add(new Order__c(Contact__c = contact.Id, Status__c = 'Draft')); 
            }
        }
        insert ordersList; 
    }
    
    global void finish(Database.BatchableContext bc){ 
    }  
}