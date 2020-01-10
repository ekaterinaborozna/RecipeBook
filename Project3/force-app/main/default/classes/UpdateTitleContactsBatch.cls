global class UpdateTitleContactsBatch implements
Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, FirstName, LastName FROM Contact';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<Contact> contactsList){
        
        for (Contact contact : contactsList) {
            if (contact.FirstName=='FirstJob'
                && contact.LastName=='SecondJob') {
                    contact.Title = 'Asynx Apex';          
                }
        } 
        update contactsList;
    }    
    global void finish(Database.BatchableContext bc){
    } 
    
}