({
	handleComponentEvent : function(component, event, helper) {
		var msgGotFromEvent = event.getParam("message");
        component.set("v.messageFromEvent",msgGotFromEvent);
	}
})