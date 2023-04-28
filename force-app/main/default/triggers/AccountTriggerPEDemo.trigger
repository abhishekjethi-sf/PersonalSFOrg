/*
 	Trigger to publish AccountEvent platform event when the Account Name starts with "Platform Event Test"
*/
trigger AccountTriggerPEDemo on Account (after insert) {
	// Logic to be written later in helper class
	list<AccountEvent__e> accountEventPEList = new list<AccountEvent__e>();
    for(Account accountRecord : trigger.new){
        if(accountRecord.Name.startsWith('Platform Event Test')){
        	accountEventPEList.add(new AccountEvent__e(Account_Id__c = accountRecord.Id,Account_Name__c = accountRecord.Name,Account_Creation_Date__c = accountRecord.CreatedDate));
        }
    }
    if(!accountEventPEList.isEmpty()){
        //Call method to publish events
        list<Database.SaveResult> accountEvents = Eventbus.publish(accountEventPEList);
        
        // Check if the events were published or not
        for (Database.SaveResult sr : accountEvents) {
            if (sr.isSuccess()) {
                System.debug('Successfully published event.' + sr);
            } else {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('Error returned: ' + err.getStatusCode() +' - ' +err.getMessage());
                }
            }       
        }
    }
}