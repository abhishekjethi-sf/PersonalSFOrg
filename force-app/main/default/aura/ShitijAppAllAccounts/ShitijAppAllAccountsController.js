({
    // Call the Init method
    doInit : function(component,event,helper) {
        helper.getAccountDetails(component); // Get the Account details
    },

    // Call the Account click logic
    accountClicked : function(component, event, helper){
        //var accountRecordId = event.currentTarget.getAttribute("data-recId");
        // Get the application event by using the e.<namespace>.<event> syntax
        var appEvent = $A.get("e.c:ShitijAppEvent");
        appEvent.setParams({
           "recordId" : event.currentTarget.getAttribute("data-recId") });
        appEvent.fire();        
    }
})