trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    list<Task> taskList = new list<Task>();
   
   //Process the Opportunities
   for(Opportunity opp : trigger.new){
        if((trigger.isInsert && opp.StageName == 'Closed Won') || (trigger.isUpdate && opp.StageName == 'Closed Won' && opp.StageName != trigger.oldMap.get(opp.Id).StageName)){
            Task task = new Task(Subject = 'Follow Up Test Task',WhatId = opp.Id);
            taskList.add(task);
        }
   }
   
   if(!taskList.isEmpty()){
        insert taskList;
   }
}