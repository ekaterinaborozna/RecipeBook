@isTest 
public class ContactLocationMapTest {
    @testSetup static void setup() {
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i = 0; i < 30; i++) {
            contacts.add(new Contact(LastName = 'Contact'));
        }
        insert contacts; 
    }
    
    @isTest static void positiveFilterTest() {        
        List<Contact> contacts = [SELECT Id, LastName FROM Contact];
        
        Test.startTest();
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(contacts);
        ContactLocationMapExtension contrClass = new ContactLocationMapExtension(stdSetController);
        contrClass.chosenSize = '30';
        contrClass.filterByField = 'Lastname';
        contrClass.textSearch = 'Contact';
        contrClass.getContacts();
        contrClass.resetFunction(); 
        contrClass.applyFilter(); 
        List<SelectOption> contactFields = contrClass.getContactFields();
        List<SelectOption> filterFields = contrClass.getFilterFields();
        List<SelectOption> itemsValues = contrClass.getItemsValues();
        Test.stopTest();
        
        List<Contact> sortContacts  = contrClass.ssc.getRecords();
        
        System.assertEquals(30, sortContacts.size());        
        System.assertNotEquals(contactFields, null);
        System.assertNotEquals(filterFields, null);
        System.assertNotEquals(itemsValues, null);
    }
    
    @isTest static void positiveSortDirectTest() {       
        List<Contact> contacts = [SELECT Id, LastName FROM Contact];
        Contact contact = new Contact(LastName = 'A_Contact');
        insert contact;
        
        Test.startTest();
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(contacts);
        ContactLocationMapExtension contrClass = new ContactLocationMapExtension(stdSetController);
        contrClass.chosenSize = '30';
        contrClass.sortByField = 'Lastname';
        contrClass.sortDirect = 'DESC';
        contrClass.sortData(); 
        Test.stopTest();

        List<Contact> sortContacts  = contrClass.ssc.getRecords();
        
        System.assertEquals('A_Contact', sortContacts[0].LastName);
    }
    
    @isTest static  void negativeFilterTest() {       
        List<Contact> contacts = [SELECT Id, LastName FROM Contact]; 
        
        Test.startTest();
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(contacts);
        ContactLocationMapExtension contrClass = new ContactLocationMapExtension(stdSetController);
        contrClass.chosenSize = '30';
        contrClass.filterByField = 'Lastname';
        contrClass.textSearch = 'Some text';
        contrClass.applyFilter(); 
        Test.stopTest();
        
        List<Contact> sortContacts  = contrClass.ssc.getRecords();
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        
        for (Apexpages.Message msg : msgs) {
            if (msg.getDetail().contains('No matching Contacts found.')) {
                b = true;
            } 
        }
        
        System.assertEquals(0, sortContacts.size()); 
        System.assert(b);
    }
    
    @isTest static  void negativeRemoteActionTest() {     
        List<Contact> contacts = [SELECT Id, LastName FROM Contact];      
        Contact contact = [SELECT Id, LastName FROM Contact LIMIT 1]; 
        String contactId = String.valueOf(contact.Id);    
        
        Test.startTest();
        String adress = ContactLocationMapExtension.getAdress(contactId);
        Test.stopTest();
        
        System.assertEquals('not found.', adress);
    }
    
    @isTest static  void positiveRemoteActionTest() {     
        List<Contact> contacts = [SELECT Id, LastName FROM Contact];      
        Contact contact = [SELECT Id, LastName FROM Contact LIMIT 1]; 
        contact.MailingCountry = 'Belarus';   
        contact.MailingCity = 'Brest'; 
        update contact; 
        String contactId = String.valueOf(contact.Id);    
        
        Test.startTest();
        String adressAfterUpdate = ContactLocationMapExtension.getAdress(contactId);    
        Test.stopTest();
        
        System.assertEquals('Belarus, Brest', adressAfterUpdate);
    }
    
    @isTest static  void positiveWithoutMailingCountryRemoteActionTest() {     
        List<Contact> contacts = [SELECT Id, LastName FROM Contact];      
        Contact contact = [SELECT Id, LastName FROM Contact LIMIT 1];   
        contact.MailingCity = 'Brest'; 
        update contact; 
        String contactId = String.valueOf(contact.Id);    
        
        Test.startTest();
        String adressAfterUpdate = ContactLocationMapExtension.getAdress(contactId);    
        Test.stopTest();
        
        System.assertEquals('Brest', adressAfterUpdate);
    }
}