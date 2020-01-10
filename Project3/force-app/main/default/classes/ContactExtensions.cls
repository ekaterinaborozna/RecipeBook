public class ContactExtensions {
    private ApexPages.StandardController sc { get; private set;}
    public List<Contact> contacts {get; set;}
    
    public ContactExtensions(ApexPages.StandardController standardController) {
          
        sc = standardController;
        Contact con=(Contact) sc.getRecord();
        System.debug(con);

       contacts = [SELECT Id, FirstName, LastName, Email FROM Contact limit 1000];
        
        
    }

}