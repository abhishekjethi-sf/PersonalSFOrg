({
	createAccount : function(component, event, helper) {
		var accRecord = component.get("v.newAccount");
        // Create Remote Action
        var act = component.get("c.createAccRecord");
        act.setParams({
            "acc" : accRecord
        });
        // Create Call back method and logic
        act.setCallback(this, function(response){
            var state = response.getState();
            console.log('####state###'+state);
            if(state === 'SUCCESS'){
                console.log('#######Account Created####'+JSON.stringify(response.getReturnValue()));
                var accEvent = component.getEvent("accEvent");
				console.log('#######accEvent####'+accEvent);    
                accEvent.setParams({
                    "newAccRecord" : response.getReturnValue()
                });
                accEvent.fire();
                component.set("v.newAccount",{ 'sObjectType':'Account', 'Name' : '', 'Site' : ''});
            } else if (state === 'ERROR'){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        // Enqueue the action
        $A.enqueueAction(act);
	}
})