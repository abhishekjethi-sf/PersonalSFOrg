({
	getAllOppts : function(component) {
		// create an action to get the Opp Data from SF
        var action = component.get("c.getAllOppts");
        action.setParams({ 
            accId : component.get("v.recordId") 
        });
        // Create a callback that is executed after the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS'){
                component.set("v.countOppts",response.getReturnValue().length);
                // Check the response length
                if(response.getReturnValue().length > 0){
                    // Get the Data
                	component.set("v.opportunities",response.getReturnValue());
                    // Get the columns correct
                    component.set("v.columns",[
                        { label: "Opportunity Name", fieldName: "Name", type: "text"},
                        { label: "StageName", fieldName: 'StageName', type: "text"},
                        { label: "Amount", fieldName: "Amount", type: "currency"}
                    ]);                    
                } else {
                    component.set("v.noOppData","No Opportunities for this Account");
                }
            }
            component.set("v.showSpinner",false);
        });
		// $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    }
})