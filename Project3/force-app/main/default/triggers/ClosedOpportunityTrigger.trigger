trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Task> taskListToInsert = new List<Task>();

    List<Opportunity> ListOpps = [SELECT Id, StageName FROM Opportunity WHERE Id IN :Trigger.New]; 
                                  
        for(Opportunity opp : ListOpps){
            Task t = new Task ( Subject='Follow Up Test Task', WhatId = opp.ID);
            taskListToInsert.add(t);
        }
    if(taskListToInsert.size()>0){
        
         insert taskListToInsert;

    }
    }