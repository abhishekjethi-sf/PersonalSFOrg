trigger OpportunityChangeTrigger on OpportunityChangeEvent (after insert) {
    OpportunityChangeTriggerHelper.createTasksOnChangeEvent(trigger.new);
}