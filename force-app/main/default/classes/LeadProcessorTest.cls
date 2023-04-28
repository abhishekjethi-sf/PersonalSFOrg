@isTest
private class LeadProcessorTest {

    @isTest static void updateLeadRecords() {
        
        list<Lead> leadList = new list<Lead>();
        for(Integer i = 1;i<=200;i++){
        	Lead lead = new Lead(LastName = 'Test Lead',Company = 'Test Company');
        	leadList.add(lead);
        }
        insert leadList;
        
        Test.startTest();
        	Database.executeBatch(new LeadProcessor(),200);
        Test.stopTest();
        
        list<Lead> updatedLeadList = [SELECT LeadSource FROM Lead];
        system.assertEquals(200,updatedLeadList.size());
        system.assertEquals('Dreamforce',updatedLeadList[0].LeadSource);
        system.assertEquals('Dreamforce',updatedLeadList[199].LeadSource);
    }
}