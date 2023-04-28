({
	createContact : function(component, event, helper) {
		var action = component.get("c.insertContact");
        action.setParams({
            "fName" : component.get("v.newContact.FirstName"),
            "lName" : component.get("v.newContact.LastName")
        });
        action.setCallback(this, function(response) {
          var state = response.getState();
            if(state === 'SUCCESS'){
                //Reset Form
                //var newCon = {'sobjectType': 'Contact','FirstName': '','LastName': ''};
                //resetting the Values in the form
                //component.set("v.newContact",newCon);
                
                // SHOW MESSAGE
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The record has been updated successfully."
                });
                toastEvent.fire();                
                
                //NAVIGATE TO RECORD PAGE
              var navEvt = $A.get("e.force:navigateToSObject");
              navEvt.setParams({
                "recordId": response.getReturnValue()
              });
                navEvt.fire();                         
            }
		});
        $A.enqueueAction(action); 
    }
})