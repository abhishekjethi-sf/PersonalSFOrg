({	
    // Get the Opportunities
	init : function(component, event, helper) {
        component.set("v.showSpinner",true);
		helper.getAllOppts(component);
	}
})