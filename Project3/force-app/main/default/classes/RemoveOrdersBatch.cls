Global class RemoveOrdersBatch Implements Database.batchable<sobject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, Status__c FROM Order__c';
        return Database.getQueryLocator(query);
    }
    global  void execute(Database.BatchableContext BC,List<Order__c> orders) {
        List<Order__c> ordersList = new List<Order__c>();
        for (Order__c order: orders) {
            if (order.Status__c == 'Draft') {
                    ordersList.add(order);    
                }  
        } 
        delete ordersList;        
    }
    global void finish(Database.BatchableContext BC) {
    }
    
}