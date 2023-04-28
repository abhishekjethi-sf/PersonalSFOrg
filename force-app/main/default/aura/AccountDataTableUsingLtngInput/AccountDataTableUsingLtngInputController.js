({
	// Get All accounts from database
    doInit : function(component, event, helper) {
		var action = component.get("c.getAccounts");
        action.setCallback(this, function(response) {
             var state = response.getState();     
            if(state == 'SUCCESS'){
                console.log("Success with state: " + state);
                component.set("v.accounts",response.getReturnValue());
            } else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);               
	}
})