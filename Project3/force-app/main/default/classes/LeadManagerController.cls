public class LeadManagerController {
    Lead lead = new Lead();
    Lead lead1 = new Lead();
    Lead lead2 = new Lead();
    Lead lead3 = new Lead();
    Lead lead4 = new Lead();
    Lead lead5 = new Lead();
    public list<Lead> firstLeadsToInsertList {get; set;}
    public list<Lead> leadsToInsertList {get; set;}
    public list<Integer> numbersNotCorrectRow {get; set;}
    public list<Integer> numbersBlankRow {get; set;}
    public Integer rowIndex {get; set;}

    public LeadManagerController() {
        firstLeadsToInsertList = new list<Lead>();
        firstLeadsToInsertList.add(lead1);
        firstLeadsToInsertList.add(lead2);
        firstLeadsToInsertList.add(lead3);
        firstLeadsToInsertList.add(lead4);
        firstLeadsToInsertList.add(lead5);
    }
    
    public ApexPages.StandardSetController Setcon { 
        get {            
            if(Setcon == Null) {
                //List<Lead> leadsList = [SELECT Name FROM Lead LIMIT 20];
                //List<Lead> leadsList = getFirstLeadsToInsertList();
                Setcon = new ApexPages.StandardSetController(FirstLeadsToInsertList);
                // sets the number of records in each page set
                setCon.setPageSize(3);
                // noOfRecords = setCon.getResultSize();
            }
            return Setcon; 
        }  
        set; 
    }
        // Initialize setCon and return a list of records
    public List<Lead> getFirstLeadsToInsertList() {
        return (List<Lead>) setCon.getRecords();
    }                                                   
                                                       
    public void addLead() {
        Lead lead = new Lead();
        firstLeadsToInsertList.add(lead);
    }
    public void save () {  
            leadsToInsertList = new list<Lead>();
            numbersNotCorrectRow = new list<Integer>();
            numbersBlankRow = new list<Integer>();
        try {
            Integer i=0;
            for (Lead lead : firstLeadsToInsertList) {
                i = i+1;
                if (lead.FirstName == null 
                    && lead.LastName == null 
                    && lead.Company == null
                    && lead.Email == null
                    && lead.Phone == null) {
                        numbersBlankRow.add(i);
                    } else if (lead.FirstName != null 
                               && lead.LastName != null 
                               && lead.Company != null
                               && lead.Email != null
                               && lead.Phone != null) {
                                   leadsToInsertList.add(lead);
                               } else { 
                                   numbersNotCorrectRow.add(i);  
                               }
            } 
            if (!leadsToInsertList.IsEmpty() 
                && numbersNotCorrectRow.IsEmpty()) {
                    
                    insert leadsToInsertList; 
                    firstLeadsToInsertList.clear();
                    //LeadManagerController ll = new LeadManagerController();
                    
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Confirm, leadsToInsertList + 'inserted successfully');
                    ApexPages.addMessage(myMsg);
                } else {
                    if (numbersNotCorrectRow.size() > 0) {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Error, 'Please, fill rows № ' + numbersNotCorrectRow );
                    ApexPages.addMessage(myMsg);   
                    }  
                } 
            if (firstLeadsToInsertList.size() > numbersBlankRow.size() 
                && numbersBlankRow.size() > 0) {
                ApexPages.Message Msg = new ApexPages.Message(ApexPages.Severity.Info, 'Blank row №' + numbersBlankRow + ' was ignored');
                ApexPages.addMessage(Msg); 
            } 
        } catch (Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There was an error' + e.getMessage() + e.getLineNumber());
            ApexPages.addMessage(myMsg);
        } 
    } 
    public void deleteRow() {
        System.debug(Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndexName')));
        rowIndex = Integer.valueOf(ApexPages.currentPage().getParameters().get('rowIndexName'));
        try {
        firstLeadsToInsertList.remove(rowIndex);    
        } catch (Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Deleting rows cause error: ' + e.getMessage());
            ApexPages.addMessage(myMsg);
        } 
    } 
}