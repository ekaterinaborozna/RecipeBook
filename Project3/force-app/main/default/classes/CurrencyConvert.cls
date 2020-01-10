public class CurrencyConvert {
    public String result { get; set; }
    public Date dateP { get; set; }
    public List<Json> resultCurrencyList { get; set; }
    public String selectedCurrency { get; set;}
    public String selectedCurrency2 { get; set;}
    public Integer sum { get; set; }
    public Integer sum2 { get; set; }
    public List<selectoption> currencyList3 { get; set;}
    public List<Json2ApexCurrencyConverter> allCurrencyList { get; set; }
    public CurrencyConvert(){
        
    }
    
    public List<selectoption> getCurrencyList() {
        List<selectoption> currencyList = new List<selectoption>();   
        currencyList.add(new selectoption ('USD','USD' ));   
        currencyList.add(new selectoption ('RUB','RUB' ));
        currencyList.add(new selectoption ('EUR','EUR' ));
        return currencyList;  
    }
    
     public List<selectoption> getCurrencyList2() {
        List<selectoption> currencyList2 = new List<selectoption>();   
        currencyList2.add(new selectoption ('USD','USD' ));   
        currencyList2.add(new selectoption ('RUB','RUB' ));
        currencyList2.add(new selectoption ('EUR','EUR' ));
        return currencyList2;  
    }
    
    public void save() {
        if(dateP!=null){
            resultCurrencyList = new List<CurrencyConvert.Json>(); 
            //String dateP = '2019-29-11';
            String RequestEndpoint = 'http://www.nbrb.by/API/ExRates/Rates?onDate='+String.valueOf(dateP.year())+
                '-'+String.valueOf(dateP.month())+
                '-'+String.valueOf(dateP.day())+'&Periodicity=0';  
            //String RequestEndpoint = 'http://www.nbrb.by/API/ExRates/Rates?onDate=2019-29-11&Periodicity=0';  
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(RequestEndpoint);  
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                List<Json2ApexCurrencyConverter> allCurrencyList = Json2ApexCurrencyConverter.parse(response.getBody());
                
                for (Integer i=0; i< allCurrencyList.size();i++){   
                    Json2ApexCurrencyConverter currencyList= allCurrencyList.get(i);   
                    Integer Cur_ID = currencyList.Cur_ID; 
                    String Cur_Abbreviation = currencyList.Cur_Abbreviation;
                    Integer Cur_Scale = currencyList.Cur_Scale;
                    String Cur_Name = currencyList.Cur_Name;
                    Double Cur_OfficialRate = currencyList.Cur_OfficialRate; 
                    //currencyList3.add(new selectoption (Cur_Abbreviation, Cur_Abbreviation));
                    resultCurrencyList.add(new Json(Cur_ID, Cur_Abbreviation, Cur_Scale, Cur_Name, Cur_OfficialRate));    
                }
            } else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'There was an error with getting information');
                ApexPages.addMessage(myMsg);
            }
        }
    }
    public class Json {  
        public Integer Cur_ID { get; set; }
        public String Cur_Abbreviation { get; set; }
        public Integer Cur_Scale { get; set; }
        public String Cur_Name { get; set; }
        public Double Cur_OfficialRate { get; set; }
        public Json (Integer Cur_ID, String Cur_Abbreviation, Integer Cur_Scale, String Cur_Name, Double Cur_OfficialRate){
            this.Cur_ID = Cur_ID;
            this.Cur_Abbreviation = Cur_Abbreviation;
            this.Cur_Scale = Cur_Scale;
            this.Cur_Name = Cur_Name;
            this.Cur_OfficialRate = Cur_OfficialRate;
        }
    }
}