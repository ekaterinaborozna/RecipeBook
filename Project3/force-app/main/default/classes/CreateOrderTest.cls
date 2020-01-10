@isTest 
public class CreateOrderTest{
    static testMethod void testCreateOrder(){
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i=0 ;i <10;i++) {
            Contact contact = new Contact(LastName='TestName');
            contacts.add(contact);
        }
        insert contacts;
        
        Test.startTest();
            CreateOrderBatch obj = new CreateOrderBatch();
            DataBase.executeBatch(obj);     
        Test.stopTest();
        
        Contact contact = [SELECT Id, Title, (SELECT Id, Status__c FROM Orders__r)
                                 FROM Contact limit 1];
        
         System.assertEquals(10, contact.Orders__r.size());  
         System.assertEquals('Draft', contact.Orders__r[0].Status__c);
        
    }
}