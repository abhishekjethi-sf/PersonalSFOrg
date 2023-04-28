({
	handleClickEvent : function(component, event, helper) {
		var appEventVar = $A.get("e.c:appEventExample");
        console.log('##event###'+appEventVar);
        appEventVar.setParams({
            "appMessage" : "Clicked on Application Event"            
        });
        appEventVar.fire();
	}
})