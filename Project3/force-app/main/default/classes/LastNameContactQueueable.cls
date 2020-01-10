public class LastNameContactQueueable implements Queueable {
    public List<Contact> contacts;
    
    public LastNameContactQueueable(List<Contact> cont){
        this.contacts = cont;
    }   
    
    public void execute(QueueableContext context) {
        
        for (Contact contact: contacts) {
            contact.LastName ='LastJob';
        }
        insert contacts; 
    }
}