public class ProjectCreateExtension { 
    private ApexPages.StandardController sc;
    public Sprint__c sprint {get; set;}
    public List<Sprint__c> sprints {get; set;}
    public String selectedSprint {get; set;}
    public Story__c story {get; set;}
    public List<Story__c> stories {get; set;}    
    //Sprint__c sprint = new Sprint__c();
    
    public ProjectCreateExtension(ApexPages.StandardController standardController) {
        // store a reference to the standard controller        
        sc = standardController;
        sprint = new Sprint__c();
        sprints = new List<Sprint__c>();
        story = new Story__c();
        stories = new List<Story__c>();
        //sprints.add(sprint);

    }
    public PageReference ToPage1() {
        return Page.ProjectCreate1;
    }
    public PageReference ToPage2() {
        if (ApexPages.CurrentPage().GetURL().ToLowerCase().StartsWith('/apex/projectcreate1')) {
            sc.Save();
        }   
        return Page.ProjectCreate2;
    }
    public PageReference ToPage3()
    {
        stories = [SELECT Id, Name, Sprint__c  FROM Story__c
                   where Sprint__c = : selectedSprint];
        return Page.ProjectCreate3;
    }
    public PageReference SaveSprint() {
        Project__c project = (Project__c)sc.GetRecord();
        sprint.Project__c = project.Id;
        insert sprint;
        
        sprints.Add(sprint);
        sprint = new Sprint__c();
        
        return null;
    }
    public PageReference SaveStory() {
        try {
            story.Sprint__c = selectedSprint;
            insert story;
            
            stories.Add(story);
            story = new Story__c();
        } catch (Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage() + e.getStackTraceString());
            ApexPages.addMessage(myMsg);
        }
        
        return null;
    }
}