({
	onchangeTypeofIdentityHelper : function(component,event,helper) {
		var selectedValue = component.get('v.selectedIdentityType');
        console.log('###selectedValue####'+selectedValue);
        
        // Get the fields from server side controller
        if(selectedValue != undefined && selectedValue != '' && selectedValue != null){
            var action = component.get("c.getRelevantIdentityFields");
            action.setParams({ 
                selectedIdentityType : selectedValue 
            });
            
            // Create a callback that is executed after the server-side action returns
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
					var result = response.getReturnValue();
                    console.log('###result###'+result);
                }
                else if (state === "INCOMPLETE") {
                    // do something
                }
                else if (state === "ERROR") {
                    // do something
                }
            });
            $A.enqueueAction(action);            
        }
	}
})