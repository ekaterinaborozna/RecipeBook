@isTest
global class UpdateCoordinatesHttpCalloutMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request) {
      
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"results" : [{"address_components" : [{"long_name": "1600","short_name": "1600","types":[ "street_number" ]}],'+'\r\n'
         +'"formatted_address":"1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",'+'\r\n'
         +'"geometry": {"location" : {"lat" : 37.4224764, "lng" : -122.0842499},"location_type" : "ROOFTOP",'+'\r\n'
         +'"viewport" : {"northeast" : {"lat" : 37.4238253802915, "lng" : -122.0829009197085},"southwest" : {"lat" : 37.4211274197085,"lng" : -122.0855988802915}}},'+'\r\n'
         +'"place_id" : "ChIJ2eUgeAK6j4ARbn5u_wAGqWA","types" : [ "street_address" ]}],"status" : "OK"}');              
        response.setStatusCode(200);
        
        return response; 
    }
}