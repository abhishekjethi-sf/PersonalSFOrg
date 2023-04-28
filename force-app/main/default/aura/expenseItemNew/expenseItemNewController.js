({
    doInit : function(component, event, helper) {
        var mydate = component.get("v.expenseItem.Date__c");
        if(mydate){
            component.set("v.formatdate", new Date(mydate));
        }
    },
    
    clickReimbursed: function(component, event, helper) {
        var expense = component.get("v.expenseItem");
        console.log('#####' + expense);
        var updateEvent = component.getEvent("updateExpense");
        console.log('##updateEvent###' + updateEvent);
        updateEvent.setParams({ "expenseEvent": expense });
        updateEvent.fire();
    }
    
})