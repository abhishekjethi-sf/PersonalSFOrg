trigger EmployeeChangeTrigger on Employee__ChangeEvent (after insert) {

    list<Task> tasks = new list<Task>();
    // Iterate through each event message
    for(Employee__ChangeEvent event : Trigger.New){
        // Get some event header fields
        EventBus.ChangeEventHeader header = event.ChangeEventHeader;
        system.debug('Received change event for ' +  header.entityName + ' for the ' + header.changeType + ' operation.');   

        // For updates, get all the fields that were explicitly set to null
        if (header.changetype == 'UPDATE') {
          if (header.nulledFields.size() > 0) {
            System.debug('The following fields were set to null in the update operation:');
            for (String field : header.nulledFields) {
              System.debug(field);
            }
          } 
        }            

        // Get record fields and display only if not null.
        // Fields can be null either because they are set to null (see nulledFields header)
        // or if unchanged.
        System.debug('Employee Changed Record Fields');
        if (event.First_Name__c != null) {
          System.debug('First Name: ' + event.First_Name__c);
        }
        if (event.Last_Name__c != null) {
          System.debug('Last Name: ' + event.Last_Name__c);
        }
        if (event.Name != null) {
          System.debug('Name: ' + event.Name);
        }
        if (event.Tenure__c != null) {
          System.debug('Tenure: ' + event.Tenure__c);
        }
        // Create a followup task
        Task tk = new Task();
        tk.Subject = 'Follow up on employee record(s): ' + header.recordIds;
        tk.OwnerId = header.CommitUser; 
        tasks.add(tk);           
    }

    // Insert tasks in bulk
    if(!tasks.isEmpty()){
        insert tasks;
    }

}