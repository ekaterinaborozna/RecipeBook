@isTest 
public class CurrencyConvertTest {
    @isTest static  void pozitiveTestGetCurrency() {
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CurrencyConvertCalloutMock());
        CurrencyConvert curClass = new CurrencyConvert();
        curClass.dateP = Date.TODAY();
        curClass.save();  
        Test.stopTest();
        
        System.assertNotEquals(null, curClass.resultCurrencyList,'The callout returned a null response.'); 
        System.assertEquals('AUD', curClass.resultCurrencyList[0].Cur_Abbreviation);  
        System.assertEquals('1', String.valueOf(curClass.resultCurrencyList[0].Cur_Scale));    
    }   
    @isTest static  void negativeExceptionTest() {
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new NegativeCurrencyConvertCalloutMock());
        CurrencyConvert curClass = new CurrencyConvert();
        curClass.dateP = Date.TODAY();
        curClass.save(); 
        Test.stopTest();
        
        System.assert(ApexPages.getMessages().size() == 1); 
        System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR),'There was an error with the getting information');
    }
}