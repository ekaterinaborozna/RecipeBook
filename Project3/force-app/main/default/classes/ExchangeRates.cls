global class ExchangeRates {  
    static Decimal usd;
    static Decimal jpy;
    static Decimal hrk;
    public Map<String,Integer> results; 
    
    public Map<String, Decimal> getRatedFromWsd() {
        
        Map<String, Decimal> results = new Map<String,Decimal>();
        
        GamaSystemComWebservices.ExchangeRatesSoap tempRatesSoap = new GamaSystemComWebservices.ExchangeRatesSoap();  
        String xmlCurrency = tempRatesSoap.GetCurrentExchangeRatesXML('BS');
        Dom.Document document = new Dom.Document();
        document.load(xmlCurrency);
        Dom.XMLNode root = document.getRootElement();
        
        for (Dom.XMLNode child : root.getChildElements()) {
           
            if(child.getChildElement('currencyLabel', null).getText().equals('USD')){
                usd = Decimal.valueOf(child.getChildElement('rateLow', null).getText());
                results.put('USD', usd);
            }
            if(child.getChildElement('currencyLabel', null).getText().equals('JPY')){
                jpy = Decimal.valueOf(child.getChildElement('rateLow', null).getText());
                results.put('JPY', jpy);
            }
            if(child.getChildElement('currencyLabel', null).getText().equals('HRK')){
                hrk = Decimal.valueOf(child.getChildElement('rateLow', null).getText());
                results.put('HRK', hrk);
            }
        }   
        return results;
    }
}