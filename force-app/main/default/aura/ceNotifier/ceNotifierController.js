({
	handleClick : function(component, event, helper) {
		var compEvent = component.getEvent("cmpEvent");
        console.log('#######'+compEvent);
        compEvent.setParams({
            "message" : "My First Event"
        });
        compEvent.fire();
	}
})