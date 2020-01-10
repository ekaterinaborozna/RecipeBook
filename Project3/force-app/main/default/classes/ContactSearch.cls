public class ContactSearch {
  public static   List<Contact> searchForContacts(String lastname, String Postalcode) {
      
    List<Contact> cts = [SELECT Id, Name FROM Contact 
                 WHERE LastName =:lastname AND MailingPostalCode=:Postalcode];   
    return cts;   
  }
}