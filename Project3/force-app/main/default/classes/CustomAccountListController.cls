public with sharing class CustomAccountListController {
    public List<SelectOption> sizeOptions {get; private set;}
    public String chosenSize {get; set;}
    
 public ApexPages.StandardSetController ssc { get; private set;}
    
    
    public CustomAccountListController() {  
        ssc = new ApexPages.StandardSetController([select Id, Name, Rating, NumberOfEmployees from Account limit 1000]);
        sizeOptions = new List<SelectOption> { 
        new SelectOption('small', 'Small'), 
        new SelectOption('medium', 'Medium'), 
        new SelectOption('large', 'Large') 
            };
        chosenSize = 'small';
        ApplyFilter(); 
      }
    
    public PageReference ApplyFilter() { 
        String query = 'Select Id, Name, Rating, NumberOfEmployees from Account where ';
        
        if (chosenSize == 'small') {  query += ' NumberOfEmployees <= 100 '; } 
        else if(chosenSize == 'medium') {  query += ' NumberOfEmployees > 100 and NumberOfEmployees <= 500 '; } 
        else {  query += ' NumberOfEmployees > 500 '; }
        query += ' limit 500 '; 
        
        ssc = new ApexPages.StandardSetController(Database.Query(query));
        
        if(ssc.GetRecords().Size() == 0) {        
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Info, 'No matching Accounts found.'));   
        } 
        return null; 
    }   
}