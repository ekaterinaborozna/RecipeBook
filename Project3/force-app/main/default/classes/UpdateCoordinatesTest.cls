@isTest
private class UpdateCoordinatesTest {
    @isTest static  void testUpdateCoordinates() {
        // Create the mock response based on a static resource
        Test.setMock(HttpCalloutMock.class, new UpdateCoordinatesHttpCalloutMock());
         HttpResponse result = UpdateCoordinatesCallout.makeGetCallout();
                
        System.assertNotEquals(null,result,'The callout returned a null response.');
        System.assertEquals(200,result.getStatusCode(),'The status code is not 200.');  
        System.assertEquals('application/json', result.getHeader('Content-Type'),'The content type value is not expected.');  
        
        Map<String, Object> result1 = (Map<String, Object>) JSON.deserializeUntyped(result.getBody());            
            List<Map<String, Object>> listresultMap = new List<Map<String, Object>>();
        for (Object instance : (List<Object>)result1.get('results')) {                
            listresultMap.add((Map<String, Object>)instance);
        }
            Map<String, Object> geometryMap = (Map<String, Object>) listresultMap[0].get('geometry') ;
            Map<String, Object> locationMap = (Map<String, Object>) geometryMap.get('location') ;

        System.assertEquals('37.4224764', String.valueOf(locationMap.get('lat')));          
    }   
}