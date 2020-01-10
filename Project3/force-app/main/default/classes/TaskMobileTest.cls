@isTest 
public class TaskMobileTest {
    @testSetup static void setup() {
        List<Task> tasks = new List<Task>();
        
        for (Integer i = 0; i < 20; i++) {
            tasks.add(new Task(Subject = 'Email'));
        }
        insert tasks; 
    }
    
    @isTest static void positiveTest() {        
        List<Task> tasks = [SELECT Id, Subject FROM Task];
        
        Test.startTest();
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(tasks);
        TaskExtension contrClass = new TaskExtension(stdSetController);
        contrClass.rowsOnPage = 30;
        contrClass.getTasks();
        Test.stopTest();
        
        List<Task> sortTasks  = contrClass.ssc.getRecords();
        
        System.assertEquals(5, sortTasks.size());  
    }
    
    @isTest static  void negativeTest() {       
        List<Task> tasks = [SELECT Id, Subject FROM Task]; 
        delete tasks;
        
        Test.startTest();
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(tasks);
        TaskExtension contrClass = new TaskExtension(stdSetController);
        contrClass.applyFilter(); 
        Test.stopTest();
        
        List<Task> sortTasks  = contrClass.ssc.getRecords();
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        
        for (Apexpages.Message msg : msgs) {
            if (msg.getDetail().contains('No matching Tasks found.')) {
                b = true;
            } 
        }
        
        System.assertEquals(0, sortTasks.size()); 
        System.assert(b);
    }
}