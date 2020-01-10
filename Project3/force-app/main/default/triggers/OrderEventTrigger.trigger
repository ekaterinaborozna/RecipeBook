trigger OrderEventTrigger on Order_Event__e (after insert) {    

    // List to hold all tasks to be created
    List<Task> tasks = new List<Task>();

    // Get User Id who is active to assign the Tasks
    User q = [Select Id From User Where IsActive = true LIMIT 1];

        // Iterate through each notification
        for(Order_Event__e event: Trigger.New){

       //get all the order shipped events
        if(event.Has_Shipped__c == true)  {

        // Create a task when order is shipped
            Task tk = new Task();
            tk.Priority = 'Medium';
            tk.Status = 'New';
            tk.Subject = 'Follow up on shipped order ' +event.Order_Number__c;
            tk.OwnerId = q.id;
            tasks.add(tk);
        }    
    }
  // Insert all tasks corresponding to events received.
    insert tasks;
}