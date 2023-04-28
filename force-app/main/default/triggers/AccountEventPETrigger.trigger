/*
 	Trigger to subscribe AccountEvent platform event 
*/
trigger AccountEventPETrigger on AccountEvent__e (after insert) {
	// Logic to be written later in helper class
	set<Id> accountIdSet = new set<Id>();
    for(AccountEvent__e eachEvent : trigger.new){
        accountIdSet.add(eachEvent.Account_Id__c);
    }
    map<Id,Account> accountMap = new map<Id,Account>([SELECT OwnerId FROM Account WHERE Id IN: accountIdSet]);
    
    //Create task records
    list<Task> taskList = new list<Task>();
    for(AccountEvent__e eachEvent : trigger.new){
        taskList.add(new Task(Subject = 'Apex Subscribed Task',Status = 'Not Started', WhatId = eachEvent.Account_Id__c,OwnerId = accountMap.get(eachEvent.Account_Id__c).OwnerId,
                     Priority = 'Normal',Description = eachEvent.Account_Name__c + ' - ' +  String.valueOf(eachEvent.Account_Creation_Date__c)));
    }
    if(!taskList.isEmpty()){
        insert taskList;
    }
    
}