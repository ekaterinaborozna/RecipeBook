@isTest
private class LeadCreatedTest {
    @isTest static void testInsertTheSameLeads() {
        Lead lead1 = new Lead(LeadSource = 'Telegram', LastName = 'Vetrov', Company = 'VRP');
        insert lead1;  
        Lead lead2 = new Lead(LeadSource = 'Telegram', LastName = 'Vetrov', Company = 'VRP');
        insert lead2;   
        
        Test.startTest();
        List<Campaign> campaignList = [Select ID, Name, ParentId, StartDate, EndDate, CreatedDate FROM Campaign Where Name = 'Telegram'];   
        Test.stopTest();  
        
        System.assertEquals(1,campaignList.size());  
    }
    
    @isTest static void testInsertLeadWithoutLeadSource() {
        Lead lead = new Lead(LastName = 'LeadWithoutLeadSource', Company = 'VRP');
        insert lead;
        
        Test.startTest();
        List<campaignMember> campaignMemberList = [Select ID, LeadId FROM CampaignMember WHERE LeadId = :lead.Id];   
        Test.stopTest(); 
        
        System.assertEquals(0, campaignMemberList.size());  
    }
    
    @isTest static void testParentCampaignDoNotExist() {
        Lead lead = new Lead(LeadSource = 'Telegram', LastName = 'Venrov', Company = 'VRP');
        insert lead; 
        List<Lead> triggerNewLeadList = new List<Lead>();  
        triggerNewLeadList.add(lead);    
        Campaign campaign= new Campaign(Name='Twitter');
        insert campaign;   
        
        Test.startTest(); 
        List<Campaign> campaignList = [Select ID, Name FROM Campaign WHERE Name = 'Telegram'];   
        Test.stopTest(); 
        
        System.assertEquals(1, campaignList.size());  
    }
    @isTest static void testBulk() {
        
        List<Lead> leads = new List<Lead>();    
        for(Integer i=0;i<20;i++) {
            leads.add(new Lead(LeadSource = 'Telegram20', LastName = 'Vetrov', Company = 'VRP'));
            leads.add(new Lead(LeadSource = 'Telegram30', LastName = 'Vetrov', Company = 'VRP'));
        }
        insert leads; 
        
        Test.startTest(); 
        List<Campaign> campaignList = [Select ID, Name FROM Campaign WHERE Name = 'Telegram20'];  
        List<Campaign> campaignParent = [Select ID, Parent.Name FROM Campaign WHERE  Parent.Name  = 'Telegram30'];      
        Test.stopTest(); 
        System.debug(campaignList);
        System.assertEquals(1, campaignList.size());  
        System.assertEquals(1, campaignParent.size());  
    }
    
}