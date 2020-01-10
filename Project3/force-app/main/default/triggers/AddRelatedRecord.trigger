trigger AddRelatedRecord on Account(after insert, after update) {
    List<Contact> oppList = new List<Contact>();
    
    // Get the related opportunities for the accounts in this trigger
    Map<Id,Account> acctsWithOpps = new Map<Id,Account>(
        [SELECT Id,(SELECT Id FROM Opportunities) FROM Account WHERE Id IN :Trigger.New]);
    
    // Add an opportunity for each account if it doesn't already have one.
    // Iterate through each account.
    for(Account a : Trigger.New) {
        System.debug('acctsWithOpps.get(a.Id).Opportunities.size()=' + acctsWithOpps.get(a.Id).Opportunities.size());
        // Check if the account already has a related opportunity.

            // If it doesn't, add a default opportunity
            oppList.add(new Contact(LastName=a.Name + ' Opportunity', AccountId = a.Id));
                   
    }
    if (oppList.size() > 0) {
        insert oppList;
    }
}