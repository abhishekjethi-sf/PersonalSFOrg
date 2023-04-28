({   
    createAccount : function(component) {
    	var action = component.get("c.insertAccount"); 
        action.setParams({
            "accName" : component.get("v.accName"),
            "accNumber" : component.get("v.accNumber"),
            "accSite" : component.get("v.accSite")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === 'SUCCESS')
            	alert('Account created in system.');
        });       
        $A.enqueueAction(action); 
	}
})