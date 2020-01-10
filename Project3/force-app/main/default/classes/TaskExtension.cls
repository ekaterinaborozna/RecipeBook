global with sharing class TaskExtension {
    public ApexPages.StandardSetController ssc {get; set;}  
    public String userId {get; set;}
    public Integer rowsOnPage {get; set;}
    public Integer numRecords {get; set;}
    
    public TaskExtension(ApexPages.StandardSetController ssc) {
        rowsOnPage = 5;
        userId = Userinfo.getUserId();
        applyFilter();
    } 
    
    public PageReference applyFilter() {         
        Set<String> fieldNames = schema.describeSObjects(new String[] {'Task'})[0].fields.getMap().keyset();
        List<String> iterableFields = new List<String>(fieldNames);
        String query = String.format('SELECT {0} FROM {1}', new String[] {String.join(iterableFields, ','), 'Task'});
        
        ssc = new ApexPages.StandardSetController(Database.Query(query));
        if (ssc.getRecords().size() == 0) {        
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Info, 'No Tasks found.'));   
        }
         ssc.setPageSize(rowsOnPage);
        
        if (ssc.getRecords().size() == 0) {        
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Info, 'No matching Tasks found.'));   
        }
        //Get page count data
        numRecords = Integer.valueOf(ssc.getResultSize()); 
        return null; 
    }   
    
     public List<Task> getTasks() { 
        List<Task> tasks = ssc.getRecords();
        return tasks;
    } 
}