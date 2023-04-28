@isTest
private class TestOpportunityChangeTrigger {

    @isTest static void testTaskCreateandUpdateCapture(){
        // Enable all the Change Data Capture entities for notifications
        Test.enableChangeDataCapture();

        // Insert Opp
        insert new Opportunity(Name = 'Sell 100 Widgets',StageName = 'Prospecting',CloseDate = Date.today().addMonths(3));
        // Call deliver to fire the trigger and deliver the test change event
        Test.getEventBus().deliver();

        // Update Opp
        Opportunity oppRecord = [SELECT StageName FROM Opportunity WHERE Name = 'Sell 100 Widgets'];
        oppRecord.StageName = 'Closed Won';
        update oppRecord;

        // Call deliver to fire the trigger and deliver the test change event
        Test.getEventBus().deliver();
        list<Task> taskList = [SELECT Id FROM Task];
        system.assertEquals(1, taskList.size());
    }

}