@isTest 
public class UpdateTitleContactTest{
    static testMethod void checkTitleContactTest(){
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i=0 ;i <200;i++) {
            Contact contact = new Contact();
            contact.FirstName ='FirstJob';
            contact.LastName ='SecondJob';
            contacts.add(contact);
        }
        insert contacts;
        
        Test.startTest();
            UpdateTitleContactsBatch obj = new UpdateTitleContactsBatch();
            DataBase.executeBatch(obj);     
        Test.stopTest();
        
        List<Contact> contact = [SELECT Id, Title
                           FROM Contact 
                           WHERE Title = 'Asynx Apex'];
        System.assertEquals(200, contact.size());
    }
       
}