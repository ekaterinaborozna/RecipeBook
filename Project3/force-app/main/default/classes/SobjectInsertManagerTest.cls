@IsTest
private class SobjectInsertManagerTest {
    @testSetup static void setup() {
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i=0; i<20; i++) {
            accounts.add(new Account(Name = 'TestAcct'+i));
            contacts.add(new Contact(LastName = 'Test' + i + 'Contact'));
        }
        insert accounts;
        insert contacts;
    }
    
    @isTest static void testGetAccountsContactsByDate() {        
        Account account = new Account (Name = 'Test Account');
        insert account;
        
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        
        String dateFormatString = 'yyyy-MM-dd';
        Date dateToday = Date.today();
        Datetime dateTimeToday = Datetime.newInstance(dateToday.year(), dateToday.month(), dateToday.day());
        String dateString = dateTimeToday.format(dateFormatString);
        request.params.put('date', dateString);
        //request.requestUri = URL.getSalesforceBaseUrl().toExternalForm()+'/services/apexrest/SobjectsInsert2/?date='+dateString; 
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        RestResourceSobjectManager.getAccountsContactsByDate();
        Test.stopTest();
        Blob responseBlob = response.responseBody;
        Integer sizeBlob = responseBlob.size();
        String stringBlob = responseBlob.toString();
        
        System.assert(stringBlob.contains(account.Id));       
    }
    
    @isTest static void testGetAccountsContactsByDateAfterDelete() {        
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        
        String dateFormatString = 'yyyy-MM-dd';
        Date dateToday = Date.today();
        Datetime dateTimeToday = Datetime.newInstance(dateToday.year(), dateToday.month(), dateToday.day());
        String dateString = dateTimeToday.format(dateFormatString);
        request.params.put('date', dateString);
        request.httpMethod = 'GET';
        RestContext.request = request;
        RestContext.response = response;
        
        List<Account> accounts = [SELECT Id FROM Account WHERE CreatedDate <= :dateToday.addDays(1) 
                                       AND CreatedDate >= :dateToday.addDays(-1)]; 
        List<Contact> contacts = [SELECT Id FROM Contact WHERE CreatedDate <= :dateToday.addDays(1) 
                                       AND CreatedDate >= :dateToday.addDays(-1)]; 
        delete accounts;
        delete contacts;
        
        Test.startTest();
        RestResourceSobjectManager.getAccountsContactsByDate();
        Test.stopTest();
        Blob responseBlob = response.responseBody;
        Integer sizeBlob = responseBlob.size();
        
        System.assertEquals(2, sizeBlob);     
    }
    
    @isTest static void testInsertAccountsContacts2() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        
        List<Account> accounts = new List<Account>();
        Account account = new Account (Name = 'InsertAccount');
        accounts.add(account);
        
        List<Account> accountsToInsert = new List<Account>();
        List<Contact> contactsToInsert = new List<Contact>();
        List<sObject> sobjects = new List<sObject>();
        
        for (Integer i=0; i<20; i++) {
            accountsToInsert.add(new Account(Name = 'TestAcct'+i));
            contactsToInsert.add(new Contact(LastName = 'Test' + i + 'Contact'));
        }
        sobjects.addAll(contactsToInsert);
        sobjects.addAll(accountsToInsert);
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        RestResourceSobjectManager.insertAccoutsContacts(sobjects);
        Test.stopTest();
        Blob responseBlob = response.responseBody;
        Integer sizeBlob = responseBlob.size();
        
        System.assertEquals(841, sizeBlob);
    }
    
    @isTest static void testInsertAccountsContactsLeads() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        
        List<Account> accountsToInsert = new List<Account>();
        List<Contact> contactsToInsert = new List<Contact>();
        List<Lead> leadsToInsert = new List<Lead>();    
        List<sObject> sobjects = new List<sObject>();
        
        for (Integer i=0; i<20; i++) {
            accountsToInsert.add(new Account(Name = 'TestAcct'+i));
            contactsToInsert.add(new Contact(LastName = 'Test' + i + 'Contact'));
            leadsToInsert.add(new Lead(LastName = 'Test' + i + 'Lead', Company = 'Test Company'));
        }
        sobjects.addAll(contactsToInsert);
        sobjects.addAll(accountsToInsert);
        sobjects.addAll(leadsToInsert);
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        RestResourceSobjectManager.insertAccoutsContacts(sobjects);
        Test.stopTest();
        
        Blob responseBlob = response.responseBody;
        Integer sizeBlob = responseBlob.size();
        
        System.assertEquals(841, sizeBlob);
    }
    
    @isTest static void testNegativeInsertLeads2() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        
        List<Lead> leadsToInsert = new List<Lead>();    
        List<sObject> sobjects = new List<sObject>();
        
        for (Integer i=0; i<20; i++) {
            leadsToInsert.add(new Lead(LastName = 'Test' + i + 'Lead', Company = 'Test Company'));
        }
        RestContext.request = request;
        RestContext.response = response;
        
        Test.startTest();
        RestResourceSobjectManager.insertAccoutsContacts(sobjects);
        Test.stopTest();
        
        Blob responseBlob = response.responseBody;
        Integer sizeBlob = responseBlob.size();
            
        System.assertEquals(2, sizeBlob);
    }
}