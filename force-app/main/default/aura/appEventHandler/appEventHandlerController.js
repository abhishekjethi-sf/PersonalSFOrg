({
	showEventMessage : function(component, event, helper) {
		var appEventMsg = event.getParam("appMessage");
        console.log('######'+appEventMsg);
        component.set("v.appEventMessage",appEventMsg);
	}
})