({
	handleClick : function(component, event, helper) {
		var btnClicked = event.getSource();
        var BtnLabel = btnClicked.get("v.label");
        component.set("v.message",BtnLabel);
	},
    handleClick2 : function (component, event, helper){
       component.set("v.message",event.getSource().get("v.label"));
    }
    
})