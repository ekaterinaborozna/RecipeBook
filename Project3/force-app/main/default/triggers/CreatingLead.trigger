trigger CreatingLead on Lead (after delete, after insert, after update, before delete, before insert, before update) {
   
    LeadTriggerHandler handler = new LeadTriggerHandler();
    
    if (Trigger.isAfter && Trigger.isInsert ){
                          handler.leadAfterInsert(Trigger.New);   
    }
    
}