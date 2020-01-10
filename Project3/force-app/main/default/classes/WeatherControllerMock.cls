@isTest
global class WeatherControllerMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        //Get Json from StaticResource
        StaticResource srObject = [select id, body from StaticResource Where Name = 'JsonForWeatherControllerTest'];
        String content = srObject.Body.toString();
        
        response.setBody(content);
        response.setStatusCode(200);
        return response; 
    }
}