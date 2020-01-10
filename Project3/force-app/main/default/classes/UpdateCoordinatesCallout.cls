public class UpdateCoordinatesCallout {
    public static HttpResponse makeGetCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://maps.googleapis.com/maps/api/geocode/json?address=Winnetka&key=AIzaSyCEtYaCEvCetMl68UsZQdTJPDoydL4BbSA');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());            
            List<Map<String, Object>> listresultMap = new List<Map<String, Object>>();
            
            for (Object instance : (List<Object>) result.get('results')) {
                listresultMap.add((Map<String, Object>)instance);
                  }
            Map<String, Object> geometryMap = (Map<String, Object>) listresultMap[0].get('geometry') ;
            Map<String, Object> locationMap = (Map<String, Object>) geometryMap.get('location') ; 
          
        }
        
        return response;
    }
}