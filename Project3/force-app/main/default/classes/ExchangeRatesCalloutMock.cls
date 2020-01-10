@isTest
global class ExchangeRatesCalloutMock implements System.WebserviceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            GamaSystemComWebservices.GetCurrentExchangeRatesXMLResponse_element respElement = new GamaSystemComWebservices.GetCurrentExchangeRatesXMLResponse_element();
            respElement.GetCurrentExchangeRatesXMLResult = '<exchangeRates><exchangeRate><bank>BS</bank><currencyLabel>USD</currencyLabel><currencyCode>840</currencyCode><nrUnits>1</nrUnits><rateLow>1.091400</rateLow><rateHigh>1.088200</rateHigh><dateIssued>2019-10-02T00:00:00+02:00</dateIssued></exchangeRate></exchangeRates>';
            response.put('response_x', respElement); 
        }
}