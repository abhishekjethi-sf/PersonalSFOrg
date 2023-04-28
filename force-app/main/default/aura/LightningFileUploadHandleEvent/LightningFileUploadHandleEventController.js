({
	handleApplicationEvent : function(component, event, helper) {
        var message = event.getParam("filerrorMessage");
        // set the handler attributes based on event data
        component.set("v.messageFromEvent", message);		
	}
})