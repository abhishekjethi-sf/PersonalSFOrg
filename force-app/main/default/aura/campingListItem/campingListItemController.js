({
	packItem : function(component, event, helper) {
		component.set("v.item.packed__c",true);
		//var a = component.get("v.item",true);
		//a.Packed__c = true;
		//component.set("v.item",a);
        var btnClicked = event.getSource();
        btnClicked.set("v.disabled",true);
	}
})