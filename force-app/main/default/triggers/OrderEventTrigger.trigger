/*
    Platform Event trigger
*/
trigger OrderEventTrigger on Order_Event__e (after insert) {
    // List to hold all tasks to be created.
    List<Task> taskList = new List<Task>();
    
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create task to dispatch new team.
            Task taskRecord = new Task();
            taskRecord.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            taskRecord.Priority = 'Medium';
            taskRecord.OwnerId = event.CreatedById;
            taskList.add(taskRecord);
        }
    }
    
    // Insert all cases corresponding to events received.
    insert taskList;
}