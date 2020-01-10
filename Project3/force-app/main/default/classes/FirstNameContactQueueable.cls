public class FirstNameContactQueueable implements Queueable {
    @testVisible
    private static Boolean doChainJob = true;
    public void execute(QueueableContext context) {
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i=0 ; i <200; i++) {
            Contact contact = new Contact (FirstName ='FirstJob');
            contacts.add(contact);    
        }
        if (doChainJob) {
            System.enqueueJob(new LastNameContactQueueable(contacts));
        }
        
    System.scheduleBatch(new UpdateTitleContactsBatch(), 'Run Batch', 20, 50);
    
    }
}