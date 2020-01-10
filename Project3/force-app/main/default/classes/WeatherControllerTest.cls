@isTest 
private class WeatherControllerTest{
    static testMethod void getWeatherTest(){
        
        Test.startTest(); 
        Test.setMock(HttpCalloutMock.class, new WeatherControllerMock());
        WeatherController controllerClass = new WeatherController();
        controllerClass.save();
        Test.stopTest();
        
        System.assertNotEquals(null, controllerClass.wrapperWeatherList);
        System.assertEquals('03.10.2019', controllerClass.wrapperWeatherList[3].dateP);
        System.assertEquals('9.0', String.valueOf(controllerClass.wrapperWeatherList[2].temperatureP));
    }   
      @isTest static  void negativeExceptionTest() {
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new NegativeWeatherControllerMock());
        WeatherController controllerClass = new WeatherController();
        controllerClass.save();
        Test.stopTest();
        
        System.assert(ApexPages.getMessages().size() == 1); 
        System.assert(ApexPages.hasMessages(ApexPages.Severity.ERROR),'There was an error with the getting information');
    }
}