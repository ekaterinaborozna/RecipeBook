public class DisplayWeatherController {
    // public List<Json2Apex.List_Z> listOfData {get; set;}
    //public String City {get; set;}
    //
    public String cityInput { get; set; }
  //  public List <WrapperWeather> wrapperWeatherList { get; set; }
    public DisplayWeatherController() {
    this.cityInput = 'dd';
    }
    public String selectedCity {get; set;}
    public List<selectoption> getselectedFieldCity(){
        List<selectoption> cityList = new List<selectoption>(); 
        cityList.add(new selectOption ('','choose city' ));  
        cityList.add(new selectOption ('Minsk','Minsk' ));   
        cityList.add(new selectOption ('Brest','Brest' ));    
        return cityList;  
    }
    public void save(){     
    }
    public static String getData(){
        final String API_KEY = '2ebaf6c6b34cc3ee65e4ab9ac76ec2f4';
        //String cityAndCode = selectedCity+',by';
        String cityAndCode = 'Minsk,by';
        //http://api.openweathermap.org/data/2.5/forecast?q=Minsk,by&APPID=2ebaf6c6b34cc3ee65e4ab9ac76ec2f4
        String RequestEndpoint = 'http://api.openweathermap.org/data/2.5/forecast?q='+cityAndCode+'&APPID='+API_KEY;  
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(RequestEndpoint);  
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) { 
            
    //        wrapperWeatherList = new List<DisplayWeatherController.WrapperWeather>();
            
            String json = response.getBody();
    //        wrapperWeatherList.add(new wrapperWeather(json));
            //Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
          //  List<Map<String, Object>> listresultMap = new List<Map<String, Object>>();
          //  for (Object instance : (List<Object>) result.get('results')) {
           //     listresultMap.add((Map<String, Object>) instance);

           //json2Apex = Json2Apex.parse(response.getBody());  
            // city = json2Apex.City.Name;
            //listOfData = json2Apex.list_Z;
     //       wrapperWeatherList = new List<WeatherController.wrapperWeather>();   
            //System.debug('json2Apex'+json2Apex);
            
            // for (Integer i = 0; i<listOfData.size(); i= i+4){
            //    Json2Apex.list_Z data1 = listOfData.get(i);
            //    Datetime tmpdate = Date.valueOf(data1.dt_txt);  
            System.debug('json'+json); 
            //String cityInput = new cityInput();
            
       // return json;  
        } 
  return null;
    }
}