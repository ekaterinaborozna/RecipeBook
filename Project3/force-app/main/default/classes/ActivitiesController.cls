public class ActivitiesController { 
    public String selectedActivity {get; set;}
    public  List<SOobjWrapper> wSobjToUpdate {get; set;} 
    public  String sortBy {get; set;}  
    public  String filterByField {get; set;}  
    public  String textSearch {get; set;}
    public  String filterByType {get; set;}
    public  Date filterByDate {get; set;}
    private integer totalRecs = 0;       
    private integer index = 0;  
    public integer blockSize = 3;  
    
    public ActivitiesController() { 
        sortBy = 'Subject';
        filterByType = 'All';
    }
    public Map<Id, SOobjWrapper> getmapSOobjWrappers() {
        Map<Id, SOobjWrapper> mapSOobjWrappers = new Map<Id, SOobjWrapper>(); 
        List<SObject> sobjectList = applyFilter();
        for (SObject sObj : sobjectList) {
            SOobjWrapper ew = new SOobjWrapper();
            ew.e = sObj;            
            ew.ts = String.valueOf(sObj.get(sortBy));
            mapSOobjWrappers.put(ew.e.Id, ew); 
        }
        return mapSOobjWrappers;
    }
    
    public void resetFunction() {
        filterByType = 'All';
        filterByField = 'None';
        filterByDate = null; 
        textSearch = null;
        applyFilter();
    }  
    
    public List<SObject> applyFilter() {
        List<SObject> sobjectList = new List<SObject> ();        
        String queryForEvents = 'SELECT Id, WhatId, OwnerId, Subject, StartDateTime, EndDateTime, EventSubtype, Type FROM Event';
        String queryForTasks = 'SELECT Id, WhatId, WhoId, TaskSubtype, Status, Type, Subject, ActivityDate FROM Task';
        //Filter settings
        if ((filterByType == 'Event' || filterByType == 'All')
            && filterByField != 'None' 
            && textSearch != null) {
                queryForEvents += ' WHERE '+ filterByField + ' Like \'%' + textSearch +'%\'' ;
            }
        if ((filterByType == 'Task' || filterByType == 'All') 
            && filterByField != 'None' 
            && textSearch != null) {
                queryForTasks += ' WHERE '+ filterByField + ' Like \'%' + textSearch +'%\'' ;
            } 
        if (filterByDate != null 
            && filterByField != 'None'
            && textSearch != null) {
                queryForTasks += ' AND ActivityDate  =:  filterByDate' ;
                queryForEvents += ' AND DAY_ONLY(StartDateTime)  =:  filterByDate';
            }
        if (filterByDate != null
            && filterByField == 'None') {
                queryForTasks += ' WHERE ActivityDate  =:  filterByDate' ;
                queryForEvents += ' WHERE DAY_ONLY(StartDateTime)  =:  filterByDate';
            }  
        //DML operations
        try {
            if (filterByType == 'Event' || filterByType == 'All') { 
                queryForEvents += ' LIMIT '+ blockSize + ' OFFSET '+ index;
                List<Event> eventsList = Database.Query(queryForEvents);
                sobjectList.addAll(eventsList);
            }
            if (filterByType == 'Task' || filterByType == 'All') {
                queryForTasks += ' LIMIT '+ blockSize + ' OFFSET '+ index;
                List<Task> tasksList = Database.Query(queryForTasks);
                sobjectList.addAll(tasksList);
            }
        } catch (Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There was DML error' + e.getMessage());
            ApexPages.addMessage(myMsg);
        } 
        if (sobjectList.size() == 0) {        
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Info, 'No matching records found'));   
        } 
        if (textSearch != ''
            && textSearch != null
            && filterByField == 'None') { 
                System.debug(textSearch);
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Choose field for searching'));   
            } 

        totalRecs = sobjectList.size();
        return sobjectList; 
    }   
    public PageReference save() {
        try {
            List<SObject> sobjToUpdate = new List<SObject>();
            
            for (SOobjWrapper sobj : wSobjToUpdate){
                sobjToUpdate.add(sobj.e);
            }            
            update sobjToUpdate;
        } catch (Exception e) {   
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'ERROR' + e.getMessage());
            ApexPages.addMessage(myMsg);     
        }   
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Сhanges have been saved');
        ApexPages.addMessage(myMsg); 
        return null;  
    } 
    public PageReference deleteActivity () { 
        Id idSObj = (Id)selectedActivity;
        sObject sObjToDelete = idSObj.getSObjectType().newSObject(idSObj);
        try {
            delete sObjToDelete;
        } catch (Exception e) {   
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'ERROR' + e.getMessage());
            ApexPages.addMessage(myMsg);     
        }   
        ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Selected records was deleted');
        ApexPages.addMessage(myMsg); 
        return null;        
    }
    
    public class SOobjWrapper implements Comparable { 
        public SObject e {get; set;}
        public String ts {get; set;}
        
        public integer compareTo(Object compareTo) {
            SOobjWrapper wrapperCompareTo = (SOobjWrapper)compareTo;
            if (ts == wrapperCompareTo.ts) {
                return 0;
            } else if (ts > wrapperCompareTo.ts) {
                return -1;
            } else{
                return 1;
            }
        }
    }
    
    public List<SOobjWrapper> getEvents() { 
        List< SOobjWrapper> events = getmapSOobjWrappers().values();
        events.sort();
        wSobjToUpdate = events;
        return events;
    }
    
    public List<SelectOption> getSortByFields() {        
        List<SelectOption> sortByFields = new List<SelectOption> { 
            new SelectOption('Subject', 'Subject'), 
                new SelectOption('Type', 'Type'),
                new SelectOption('WhatId', 'Related To')   
                };
                    return sortByFields;
    } 
    
    public List<SelectOption> getFilterFields() {        
        List<SelectOption> filterFields = new List<SelectOption> { 
            new SelectOption('None', 'None'),
                new SelectOption('Type', 'Type'),
                new SelectOption('Subject', 'Subject')
                };
                    return filterFields;
    } 
    
    public List<SelectOption> getFilterTypeObj() {        
        List<SelectOption> filterTypeObj = new List<SelectOption> { 
            new SelectOption('All', 'All'),
                new SelectOption('Event', 'Event'),
                new SelectOption('Task', 'Task')
                };
                    return filterTypeObj;
    } 
    //Pagination
    public void beginning() { 
        index = 0;  
    }  
    
    public void previous() {  
        index = index - blockSize;  
    }  
    
    public void next() {
        index = index + blockSize;
    } 
    
    public void end() {  
        index = totalrecs - math.mod(totalRecs,blockSize);  
    } 
    
    public boolean getprev() {  
        if(index == 0) { 
            return true;  
        } else { 
            return false;
        } 
    } 
    
    public boolean getnxt() {  
        if((index + blockSize) > totalRecs) { 
            return true;  
        } else { 
            return false;
        }
    }   
}