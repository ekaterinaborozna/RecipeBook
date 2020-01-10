@isTest 
private class UpdateSalaryAccountTest{
    static testMethod void checkSalaryAccountTest(){
        
        Account account = new Account();
        account.Name ='FirstJob';
        account.ExchangeCurrencyContainer__c ='USD';
        insert account;
        
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i=0 ;i <20;i++) {        
            Contact contact = new Contact();   
            contact.LastName = 'Test';
            contact.CurrencyContainer__c ='USD';
            contact.AccountId = account.Id;
            contact.Salary__c = 10;
            contacts.add(contact);
        }
        insert contacts;
        
        Test.startTest(); 
        ExchangeRates ex = new ExchangeRates();
        Test.setMock(System.WebServiceMock.class, new ExchangeRatesCalloutMock());
        Map<String, Decimal> output = ex.getRatedFromWsd(); 
        UpdateSalaryAccountBatch batch = new UpdateSalaryAccountBatch();
        Database.executeBatch(batch);
        Test.stopTest();
        
        Account acc = [SELECT Id, Name, SalaryAmount__c
                       FROM Account 
                       WHERE Name = 'FirstJob' LIMIT 1];
        
        //Test method 'ExchangeRates'
        System.assertEquals(1.091400, output.get('USD'));
        //Test batch 'UpdateSalaryAccountBatch'
        System.assertEquals(200, acc.SalaryAmount__c.intValue());
    }   
}