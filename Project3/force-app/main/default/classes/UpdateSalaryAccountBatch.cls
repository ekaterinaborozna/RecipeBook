global class UpdateSalaryAccountBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, Name, SalaryAmount__c, ExchangeCurrencyContainer__c, (SELECT Id, Salary__c, CurrencyContainer__c FROM Contacts WHERE CurrencyContainer__c!=null)  FROM Account WHERE ExchangeCurrencyContainer__c!=null';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> accountList) {
        ExchangeRates exchangerates = new ExchangeRates();
        
        Decimal usd = exchangerates.getRatedFromWsd().get('USD');
        System.debug('usd'+usd);  
        Decimal hrk = exchangerates.getRatedFromWsd().get('HRK');
        Decimal jpy = exchangerates.getRatedFromWsd().get('JPY');
        
        for (Account account : accountList) {
            Decimal accountSalary = 0;
            String currencyAccount = account.ExchangeCurrencyContainer__c;
            for (Contact contact : account.Contacts) {
                String currencyContact = contact.CurrencyContainer__c;
                Decimal salaryContact = contact.Salary__c;
                if (currencyContact != null
                    && salaryContact != null){
                        accountSalary = accountSalary + (salaryContact / exchangerates.getRatedFromWsd().get(currencyContact) * exchangerates.getRatedFromWsd().get(currencyAccount));
                    }  
            }
            account.SalaryAmount__c = accountSalary;  
        }        
        update accountList;   
    } 
    
    global void finish(Database.BatchableContext BC){
    }  
}