@isTest 
public class ActivitiesTest {
    
    @testSetup static void setup() {
        Date dateToday = Date.today();
        Datetime dateTimeToday = Datetime.newInstance(dateToday.year(), dateToday.month(), dateToday.day());
        List<Event> events = new List<Event>();
        for (Integer i = 0; i < 200; i++) {
            events.add(new Event(Subject = 'Event',
                                 DurationInMinutes = 10,
                                 ActivityDateTime = dateTimeToday)
                      );
        }
        insert events;        
        List<Task> tasks = new List<Task>();
        for (Integer i = 0; i < 200; i++) {
            tasks.add(new Task(Subject = 'Task')
                     );
        }
        insert tasks; 
    }
    
    @isTest static  void pozitiveTest() {
        
            Test.startTest();
            ActivitiesController activityClass = new ActivitiesController();
            activityClass.blockSize = 1000;
            List<SObject> sobjectList = activityClass.applyFilter();
            
            Test.stopTest();
            
            List<Event> eventsList = new List<Event>();
            List<Task> tasksList = new List<Task>();
            for (SObject sobj : sobjectList) {   
                if (sobj.getSObjectType() == Event.getSObjectType()) {
                    eventsList.add((Event)sobj);
                }  
                if (sobj.getSObjectType() == Task.getSObjectType()) {
                    tasksList.add((Task)sobj);
                }  
            }
        
            System.assertEquals(400, sobjectList.size());
            System.assertEquals(200, eventsList.size());
        }   
        @isTest static  void filterTest() {
        
            Test.startTest();
            ActivitiesController activityClass = new ActivitiesController();
            activityClass.blockSize = 1000;
            activityClass.filterByType = 'All';
            activityClass.filterByField = 'Subject';
            activityClass.textSearch = 'Task';
            List<SObject> sobjectList = activityClass.applyFilter();            
            Test.stopTest();
            
            List<Event> eventsList = new List<Event>();
            List<Task> tasksList = new List<Task>();
            for (SObject sobj : sobjectList) {   
                if (sobj.getSObjectType() == Event.getSObjectType()) {
                    eventsList.add((Event)sobj);
                }  
                if (sobj.getSObjectType() == Task.getSObjectType()) {
                    tasksList.add((Task)sobj);
                }  
            }
        
            System.assertEquals(200, sobjectList.size());
            System.assertEquals(200, tasksList.size());
            System.assertEquals(0, eventsList.size());
        }
    
     @isTest static  void deleteTest() {
        
            Test.startTest();
            ActivitiesController activityClass = new ActivitiesController();
            List<Task> tasks = [SELECT Id FROM Task];
            activityClass.selectedActivity = tasks[0].Id;
            activityClass.blockSize = 1000;
            activityClass.deleteActivity();
            List<SObject> sobjectList = activityClass.applyFilter();
            activityClass.resetFunction();
            Test.stopTest();
            
            List<Event> eventsList = new List<Event>();
            List<Task> tasksList = new List<Task>();
            for (SObject sobj : sobjectList) {   
                if (sobj.getSObjectType() == Event.getSObjectType()) {
                    eventsList.add((Event)sobj);
                }  
                if (sobj.getSObjectType() == Task.getSObjectType()) {
                    tasksList.add((Task)sobj);
                }  
            }
        
            System.assertEquals(399, sobjectList.size());
            System.assertEquals(199, tasksList.size());
            System.assertEquals(200, eventsList.size());
        }
         @isTest static  void sortTest() {
        
            Test.startTest();
            ActivitiesController activityClass = new ActivitiesController();            
            activityClass.blockSize = 1000;
            activityClass.sortBy = 'Subject';
            Map<Id, ActivitiesController.SOobjWrapper> mapSOobjWrappers = activityClass.getmapSOobjWrappers();
            System.debug('mapSOobjWrappers'+mapSOobjWrappers) ;
            Test.stopTest();
             
            String resultSort = mapSOobjWrappers.values()[0].ts;
            System.debug(mapSOobjWrappers.values()[0]) ;
            System.assertEquals('Event', String.valueOf(resultSort));
        }
    }