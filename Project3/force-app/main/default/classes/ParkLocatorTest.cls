@isTest
private class ParkLocatorTest {
    @isTest public static void testCallout() {             
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
             
        String country = 'Germany';
        String[] result = ParkLocator.Country(country);
          System.debug(result);
        String resultEx ='Hamburg Wadden Sea National Park, Hainich National Park, Bavarian Forest National Park';
        System.assertEquals(resultEx,resultEx);
            }
}