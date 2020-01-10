@isTest 
public class LeadManagerControllerTest {
    @isTest static  void pozitiveTestGetCurrency() {
        Lead lead = new Lead(LastName = 'FirstJob', FirstName = 'Test', Company = 'Hl', Phone='4562545', Email = 'vd@mail.ru' );
        
        List<Lead> leadsToInsertList = new List<Lead>(); 
        leadsToInsertList.add(lead);        
        
        Test.startTest();
        LeadManagerController curClass = new LeadManagerController();
        curClass.addLead();
        curClass.firstLeadsToInsertList.add(lead);
        curClass.save();
        Test.stopTest();
        
        Lead selectedLead = [Select Id, LastName 
                     FROM Lead 
                     WHERE LastName = 'FirstJob' 
                     LIMIT 1];
        
        System.assertEquals('FirstJob', selectedLead.LastName);
    }   
}