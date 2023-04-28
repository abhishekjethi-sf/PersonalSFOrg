public with sharing class OpportunityChangeTriggerHelper {

    // Create tasks on Change operation
    public static void createTasksOnChangeEvent(list<OpportunityChangeEvent> oppEventList){
        list<Task> taskList = new list<Task>();

        for(OpportunityChangeEvent oppEvent : oppEventList){
            // Get some event header fields
            EventBus.ChangeEventHeader header = oppEvent.ChangeEventHeader;
            system.debug('Received change event for ' +  header.entityName + ' for the ' + header.changeType + ' operation.');

            // For updates, check the fields
            if (header.changetype == 'UPDATE' && oppEvent.isWon ==  true) {
                Task taskRecord = new Task();
                taskRecord.Subject = 'Follow up on employee record(s): ' + header.recordIds;
                taskRecord.OwnerId = header.CommitUser;     
                taskList.add(taskRecord);                        
            }

            if(!taskList.isEmpty()){
                insert taskList;
            }
        }   
    }
}