public class WeatherController {
    public List<Json2Apex.List_Z> listOfData { get; set; }
    public String selectedCity { get; set;}
    public List<wrapperWeather> wrapperWeatherList { get; set; }
    
    public List<selectoption> getCityList() {
        List<selectoption> cityList = new List<selectoption>();   
        cityList.add(new selectoption ('Minsk','Minsk' ));   
        cityList.add(new selectoption ('Brest','Brest' ));
        cityList.add(new selectoption ('Vitebsk','Vitebsk' ));
        return cityList;  
    }   
    public void save() {
        wrapperWeatherList = new List<WeatherController.WrapperWeather>();
        //Final String API_KEY = '2ebaf6c6b34cc3ee65e4ab9ac76ec2f4';
        Final String API_KEY = ApiKeyWeather__c.getInstance().Forecast__c;
        String cityAndCode = selectedCity;
        cityAndCode += ',by';
        String requestEndpoint = 'http://api.openweathermap.org/data/2.5/forecast?q='+cityAndCode+'&APPID='+API_KEY;  
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndpoint);  
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response. 
        if (response.getStatusCode() == 200) {
            Json2Apex json2Apex = Json2Apex.parse(response.getBody()); 
            listOfData = json2Apex.List_Z;    
            for (Integer i=0; i< listOfData.size(); i = i+4 ) {
                Json2Apex.List_Z data1 =  listOfData.get(i);
                Datetime tmDate = Date.valueOf(data1.dt_txt);  
                Json2Apex.Main main1 = data1.main;        
                String dateP = tmDate.format('dd.MM.YYYY');
                String timeP = data1.dt_txt;
                Double temperatureP = (Integer) (main1.temp - 273.15); 
                Double pressureP = main1.pressure;
                String weatherP = data1.weather.get(0).main; 
                String CloudPercentP = data1.clouds.all+'%'; 
                String SpeedWindP = data1.wind.speed+'m/s';     
                wrapperWeatherList.add(new wrapperWeather(dateP, timeP, temperatureP, pressureP, weatherP, CloudPercentP, SpeedWindP));    
            }   
        } else {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'There was an error with the getting information.');
            ApexPages.addMessage(myMsg);
        } 
    }
    
    public class WrapperWeather {  
        public String dateP { get; set; }
        public String timeP { get; set; }
        public Double temperatureP { get; set; }
        public Double pressureP { get; set; }
        public String weatherP { get; set; }
        public String CloudPercentP { get; set; }
        public String SpeedWindP { get; set; }
        
        public WrapperWeather (String dateP, String timeP, Double temperatureP, Double pressureP, String weatherP, String CloudPercentP, String SpeedWindP){
            this.dateP = dateP;
            this.timeP = timeP;
            this.temperatureP = temperatureP;
            this.pressureP = pressureP;
            this.weatherP = weatherP;
            this.CloudPercentP = CloudPercentP;
            this.SpeedWindP = SpeedWindP;
        }
    }
}