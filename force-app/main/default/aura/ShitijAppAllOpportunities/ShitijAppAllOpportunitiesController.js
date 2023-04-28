({
    handleApplicationEvent : function(component, event, helper) {
        var accountRecordId = event.getParam("recordId");
        helper.getOppDetails(component,accountRecordId); // Get the Contact details
    }
})