@isTest
private class TestVerifyDate {
    
    @isTest static void date2in30days() {
       date result1 = VerifyDate.CheckDates( date.newInstance(2019, 03, 01), date.newInstance(2019, 03, 05) );
        System.assertEquals( date.newInstance(2019, 03, 05), result1 );}
    
    @isTest static void date2beyond30days() {
       date result2 = VerifyDate.CheckDates( date.newInstance(2019,03,01), date.newInstance(2019,04,05) );
        System.assertEquals( date.newInstance(2019,03,31), result2 ) ;}
    
    @isTest static void date2equaldate1() {
       date result3 = VerifyDate.CheckDates( date.newInstance(2019,03,01), date.newInstance(2019,03,01) );
        System.assertEquals( date.newInstance(2019,03,01), result3 );}         
    
    @isTest static void date2beforedate1() {
       date result4 = VerifyDate.CheckDates(date.newInstance(2019,03,01),date.newInstance(2019,02,05));
        System.assertEquals( date.newInstance(2019,03,31), result4) ; }
    }