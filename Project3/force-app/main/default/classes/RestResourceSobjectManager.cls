@RestResource(urlMapping='/RestSobjectsManager/*')
global with sharing class RestResourceSobjectManager {
    @HttpGet
    // /services/apexrest/RestSobjectsManager/?date=2019-10-03
    global static void getAccountsContactsByDate() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        List<Id> accountAndContactsIds = new List<Id>(); 
        
        try { 
            String dateParam = RestContext.request.params.get('date');
            dateParam = dateParam.replaceAll('/','-');
            Date dateP = Date.valueOf(dateParam);
            List<Account> accounts =  [SELECT Id, CreatedDate 
                                       FROM Account
                                       WHERE DAY_ONLY(CreatedDate) =: dateP];
            List<Contact> contacts =  [SELECT Id, CreatedDate 
                                       FROM Contact 
                                       WHERE DAY_ONLY(CreatedDate) =: dateP];
            
            for (Account account: accounts) {   
                accountAndContactsIds.add(account.Id); 
            }
            for (Contact contact: contacts) {
                accountAndContactsIds.add(contact.Id);     
            } 
            response.responseBody = Blob.valueOf(JSON.serialize(accountAndContactsIds));
            response.statusCode = 200;
        } catch (Exception e) {
            response.responseBody = Blob.valueOf('Exception type caught: ' + e.getTypeName() + ' Message: '+ e.getMessage());
            response.statusCode = 400;
        }
    }
    
    @HttpPost
    global static void insertAccoutsContacts(List<Sobject> sobjectsList) { 
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        List<Sobject> accountsContactsToInsert = new List<Sobject>();
        try {
            for (Sobject ob : sobjectsList) { 
                if (ob.getSObjectType() == Account.getSObjectType()) {
                    String name = (String)ob.get(Schema.Account.Name); 
                    if (name != null) {
                        accountsContactsToInsert.add(ob);       
                    }  
                }
                if (ob.getSObjectType() == Contact.getSObjectType()) {
                    String lastName = (String)ob.get(Schema.Contact.LastName); 
                    if (lastName != null) {
                        accountsContactsToInsert.add(ob);       
                    }  
                }
            }  
            if (!accountsContactsToInsert.IsEmpty()) {  
                insert accountsContactsToInsert;  
            } 
            Map<Id, Sobject> accountsContactsMap = new Map<Id, Sobject>(accountsContactsToInsert); 
            response.responseBody = Blob.valueOf(JSON.serialize(new List<Id>(accountsContactsMap.keySet())));
            response.statusCode = 200;  
        } catch (Exception e) {
            response.responseBody = Blob.valueOf('Exception type caught: ' + e.getTypeName() + ' Message: '+ e.getMessage());
            response.statusCode = 400;
        }  
    }    
}