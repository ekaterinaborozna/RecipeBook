global with sharing class CharityFormExtension {
     public ApexPages.StandardSetController ssc {get; set;} 
    
    
        public CharityFormExtension(ApexPages.StandardSetController standardController) {  
        ssc = standardController;  
    } 
    
    @RemoteAction 
    global static Boolean getRemoteCampaignDate() {
        String selectedCampaignId = '7012v000002BEY7AAO'; 
        Campaign selectedCampaign = [SELECT Id, StartDate, EndDate FROM Campaign WHERE Id=: selectedCampaignId LIMIT 1];
        System.debug(selectedCampaign.StartDate);
        
        //String dateFormatString = 'yyyy-MM-dd';
        Date dateToday = Date.today();
        Datetime dateTimeToday = Datetime.newInstance(dateToday.year(), dateToday.month(), dateToday.day());
        //String dateString = dateTimeToday.format(dateFormatString);
        
        System.debug('StartDate' + selectedCampaign.StartDate);
        System.debug('EndDate' + selectedCampaign.EndDate);
         Boolean showOrNot = false;   
        if (selectedCampaign.StartDate<= dateToday &&
            selectedCampaign.EndDate>= dateToday) {
                showOrNot = !showOrNot; 
            }
        return showOrNot;
    }
}