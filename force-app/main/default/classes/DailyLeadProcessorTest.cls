@isTest
private class DailyLeadProcessorTest {
	
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
	
    @isTest static void updateLeadRecords() {
        list<Lead> leadList = new list<Lead>();

        for(Integer i = 0;i<200;i++){
        	leadList.add(new Lead(LAstName = 'Test Lead '+ i, Company = 'Test Company'));
        }
        insert leadList;
        system.assertEquals(200,leadList.size());
        
        Test.startTest();
        	system.schedule('Update Lead Records' ,CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        list<Lead> updatedLeadList = [SELECT LeadSource FROM Lead];
        system.assertEquals('Dreamforce',updatedLeadList[0].LeadSource);
        system.assertEquals('Dreamforce',updatedLeadList[199].LeadSource);
     }
}