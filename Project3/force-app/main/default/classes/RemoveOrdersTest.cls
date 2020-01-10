@isTest 
public class RemoveOrdersTest{
    static testMethod void testRemoveOrders() {
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i=0 ;i <200;i++) {
            Contact contact = new Contact();
            contact.FirstName ='FirstJob';
            contact.LastName ='SecondJob';
            contacts.add(contact);
        }
        insert contacts;
        
        List<Order__c> orders = new List<Order__c>();
        
        for(Contact contact:contacts){
            Order__c order = new Order__c (
                Name = 'Order__c for test ',
                Status__c = 'Draft',
                Contact__c = contact.Id
            );
            orders.add(order);
        }
        insert orders;     
        
        Test.startTest();
        RemoveOrdersBatch obj = new RemoveOrdersBatch();
        DataBase.executeBatch(obj);     
        Test.stopTest();
        
        Contact contact = [SELECT Id, Title, (SELECT Id, Status__c FROM Orders__r)
                           FROM Contact limit 1];
        
        System.assertEquals(0, contact.Orders__r.size()); 
    }
}