({
	changeRadioBtn : function(component, event, helper) {
		var btnClicked = event.getSource().get("v.value");
        console.log('btnClicked'+btnClicked);
        component.set('v.value',btnClicked);
        console.log('value'+component.get('v.value'));
	}
})