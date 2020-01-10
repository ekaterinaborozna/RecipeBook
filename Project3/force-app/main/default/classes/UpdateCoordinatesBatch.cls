global class UpdateCoordinatesBatch implements
Database.Batchable<sObject>, Database.AllowsCallouts {
    private static final String adress='AIzaSyCEtYaCEvCetMl68UsZQdTJPDoydL4BbSA';
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, Location__c, MailingPostalCode, MailingState, MailingCountry, MailingCity, MailingStreet FROM Contact';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Contact> contactList) {
        for (Contact contact : contactList){
            
            Http http=new Http();            
            HttpRequest req=new HttpRequest();
            String sText='https://maps.googleapis.com/maps/api/geocode/json?address='+contact.MailingCountry+'+'+contact.MailingStreet+'&key='+ adress;    
            sText= sText.replaceAll( '\\s+', '');    
            req.setEndpoint(sText);
            //Get data    
            req.setMethod('GET');     
            HttpResponse res=http.send(req);   
            
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());            
            List<Map<String, Object>> listresultMap = new List<Map<String, Object>>();
            for (Object instance : (List<Object>) result.get('results')) {
                listresultMap.add((Map<String, Object>) instance);
            }
            Map<String, Object> geometryMap = (Map<String, Object>) listresultMap[0].get('geometry') ;
            Map<String, Object> locationMap = (Map<String, Object>) geometryMap.get('location') ; 
            
            contact.location__latitude__s = (Decimal)locationMap.get('lat'); 
            contact.location__longitude__s = (Decimal)(locationMap.get('lng'));  
            
        }
        update contactList;
    }
    global void finish(Database.BatchableContext BC){
    }   
    
}