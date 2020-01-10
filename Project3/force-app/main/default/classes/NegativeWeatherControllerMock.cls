@isTest
global class NegativeWeatherControllerMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setStatusCode(306);
        return response; 
    }
}