public class LeadTriggerHandler { 
    public void leadAfterInsert(List<Lead> triggerNewLeadList){   
        Date datetoday1 = Date.today().toStartOfMonth();
        Date datetoday2 = Date.today().addMonths(1).toStartOfMonth().addDays(-1);
        
        List<Campaign> campaignParentToInsert = new List<Campaign>();
        List<Campaign> campaignParentToInsertNoDuplicates = new List<Campaign>();
        Set<String> nameCampaignParent = new Set<String>();
        List<Campaign> campaignChildToInsert = new List<Campaign>(); 
        
        List <String> leadSourceFields = new List <String>();
        for (Lead mylead : triggerNewLeadList){
            if(mylead.LeadSource!=null){
                leadSourceFields.add(mylead.LeadSource);
            }
        }
        List<Campaign> campaignList = [SELECT Id, Name, ParentId, StartDate, EndDate, CreatedDate FROM Campaign 
                                       WHERE Name =: leadSourceFields
                                       OR (StartDate =: datetoday1
                                           AND EndDate =: datetoday2)
                                      ]; 
        
        // Method to create Campaign member, campaignParentToInsert
        MatchLeadWithCampaign(triggerNewLeadList,
                              leadSourceFields, campaignList,
                              campaignParentToInsert); 
        if (campaignParentToInsert.size()>0){
            for(Campaign camp: campaignParentToInsert){
                if(!nameCampaignParent.contains(camp.Name)){
                    nameCampaignParent.add(camp.Name);     
                    campaignParentToInsertNoDuplicates.add(camp);     
                } 
            }
            campaignParentToInsert = campaignParentToInsertNoDuplicates.clone();   
            insert campaignParentToInsert; 
            for(Campaign newcampaign: campaignParentToInsert){
                campaignList.clear();
                campaignList.add(newcampaign);
                Campaign a = new Campaign (
                    ParentId = newcampaign.id,
                    Name = newcampaign.Name+'_'+Date.today().month()+'_'+Date.today().year(),
                    StartDate = Date.today().toStartOfMonth(),
                    EndDate = Date.today().addMonths(1).toStartOfMonth().addDays(-1)
                );
                campaignChildToInsert.add(a);
            }
            campaignParentToInsert.clear();
            //Insert Child Campaigns
            insert campaignChildToInsert; 
            //Add Child Campaigns to campaignList
            for(Campaign mycampaign: campaignChildToInsert){ 
                campaignList.add(mycampaign);    
            }
            MatchLeadWithCampaign(triggerNewLeadList, LeadSourceFields, CampaignList, campaignParentToInsert);      
        }  
    }
    
    private static List<Campaign> MatchLeadWithCampaign(
        List<Lead> triggerNewLeadList,
        List <String> leadSourceFields,
        List<Campaign> campaignList,
        List<Campaign> campaignParentToInsert){ 
        List<CampaignMember> campaignMemberList = new List<CampaignMember>();     
        
        //Get Map: ID ParentCampaign, Name ParentCampaign
        Map<ID, String> NameParentCampaignMap = new Map<ID, String>();
        for (Campaign mycamp : CampaignList) {
            if (mycamp.ParentId == null && LeadSourceFields.contains(mycamp.Name)) {
                NameParentCampaignMap.put(mycamp.ID, mycamp.Name);   
            }       
        }  System.debug('NameParentCampaignMap'+NameParentCampaignMap);                                                 
        //Get Map: Name ParentCampaign (with matching Name), ID ChildCampaign (with matching Date)
        Map<String, ID> ChildCampaignMap = new Map<String, ID>();
        for (Campaign camp : CampaignList){
            if (Date.today() < camp.EndDate 
                && Date.today() > camp.StartDate 
                && LeadSourceFields.contains(NameParentCampaignMap.get(camp.ParentId)) 
                && NameParentCampaignMap.get(camp.ParentId) != null){
                   ChildCampaignMap.put(NameParentCampaignMap.get(camp.ParentId), camp.Id);    
               }
        }
        System.debug('ChildCampaignMap'+ChildCampaignMap);                                                      
        //Circle for creating CampaignMember 
        for (Lead mylead : triggerNewLeadList){
            if(ChildCampaignMap.get(mylead.LeadSource)!= null ){
                campaignMemberList.add(new CampaignMember(
                    CampaignId = ChildCampaignMap.get(mylead.LeadSource),    
                    LeadId = mylead.id                
                ));    
            } else {
                if(mylead.LeadSource!=null){
                    campaignParentToInsert.add(new Campaign(
                        Name = mylead.LeadSource                                
                    ));   
                }  
            }
        } 
        
        if (campaignMemberList.size() > 0) {
            insert campaignMemberList;  
        } 
            return campaignParentToInsert ;
    }
    
}