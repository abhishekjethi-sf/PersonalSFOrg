({  
    // http://sfdcmonkey.com/2018/01/05/lightning-datatable-base-component/ - Data Table with wrapper
    handleApplicationEvent : function(component, event, helper) {
        var accountRecordId = event.getParam("recordId");
        helper.getContactDetails(component,accountRecordId); // Get the Contact details
    }
})