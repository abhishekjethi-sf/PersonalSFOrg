({
	getCaseData : function(component) {
        //Pass the record Id to the server method
        var action = component.get("c.getCaseDataFromServer");
        action.setParams({ 
            caseId : component.get("v.recordId") 
        });

        // Create a callback that is executed after 
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
				var dataWrapper = response.getReturnValue();
                console.log('dataWrapper JSON##: ' + JSON.stringify(dataWrapper));
                component.set("v.currentStep",dataWrapper.currentStep);
             	// Make the array from Map
                var steps=[];
                for(var key in dataWrapper.stepDataMap){
                    steps.push({label: dataWrapper.stepDataMap[key], value: key});
                }
                component.set("v.allSteps",steps);
            }
            else if (state === "ERROR") {
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
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);        
	}
})