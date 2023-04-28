@isTest
private class TestVerifyDate {

    @isTest static void Date2Greater45DaysDate1() {
        Date date1 = system.today();
        Date date2 = system.today().addDays(45);
		Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);        
		// Check the returned date
        Date date3 = VerifyDate.CheckDates(date1,date2);
        system.assertEquals(date3,lastDay);
    }
    
    @isTest static void Date2Greater10DaysDate1() {
        Date date1 = system.today();
        Date date2 = system.today().addDays(10);
		// Check the returned date
        Date date3 = VerifyDate.CheckDates(date1,date2);
        system.assertEquals(date3,date2);
    }    
    
    @isTest static void Date1LessDate2() {
        Date date1 = system.today();
        Date date2 = system.today().addDays(-10);
		Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
		Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);               
		// Check the returned date
        Date date3 = VerifyDate.CheckDates(date1,date2);
        system.assertEquals(date3,lastDay);
    } 
        
}