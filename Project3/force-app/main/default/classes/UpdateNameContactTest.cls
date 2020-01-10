@isTest
public class UpdateNameContactTest {
    static testmethod void firstNameContactTest() {        
        FirstNameContactQueueable.doChainJob = false;
        
        Test.startTest();        
        ID jobID = System.enqueueJob(new FirstNameContactQueueable());
        Test.stopTest();
        
        AsyncApexJob jobsID =  [SELECT Id, Status, NumberOfErrors 
                                FROM AsyncApexJob 
                                WHERE Id = :jobID 
                                limit 1];
        
        System.assertEquals('Completed', jobsID.Status);
        System.assertEquals(0, jobsID.NumberOfErrors);   
    }
    static testmethod void lastNameContactTest() {
        
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i=0 ;i <200;i++) {
            Contact contact = new Contact (FirstName ='FirstJob');
            contacts.add(contact);    
        }    
        
        Test.startTest();        
        ID jobID = System.enqueueJob(new LastNameContactQueueable(contacts));
        Test.stopTest();
        
        AsyncApexJob jobsID =  [SELECT Id, Status, NumberOfErrors 
                                FROM AsyncApexJob 
                                WHERE Id = :jobID 
                                limit 1];
        Contact contact = [SELECT Id, LastName
                           FROM Contact
                           limit 1];
        
        System.assertEquals('Completed', jobsID.Status);
        System.assertEquals(0, jobsID.NumberOfErrors); 
        System.assertEquals('LastJob', contact.LastName);  
    }  
    static testmethod void updaterNameContactShedulerTest() {
        
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i=0 ;i <200;i++) {
            Contact contact = new Contact (FirstName ='FirstJob');
            contacts.add(contact);    
        }                 
        LastNameContactQueueable updaterLastNameContact = new LastNameContactQueueable(contacts);
        
        Test.startTest();        
        String jobId = System.enqueueJob(updaterLastNameContact); 
        Test.stopTest();
        
        AsyncApexJob jobsID =  [SELECT Id, Status, NumberOfErrors 
                                FROM AsyncApexJob 
                                WHERE Id = :jobID 
                                limit 1];
        Contact contact = [SELECT Id, LastName
                           FROM Contact
                           limit 1];
        
        System.assertEquals('Completed', jobsID.Status);
        System.assertEquals(0, jobsID.NumberOfErrors);
    }    
}