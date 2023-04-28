({
	handleClick : function(component, event, helper) {
		console.log('###accId##'+component.get('v.accountId'));
        var accId = component.get('v.accountId');
        var urlEvent = $A.get("e.force:navigateToURL");
        //var urlEvent = $A.get("e.force:navigateToComponent");
        urlEvent.setParams({
          'url': '/lightning/n/NavigateToCmp2?accountId='+ accId
          //componentDef: "c:NavigateToCmp2"
        });
        urlEvent.fire();        
	}
})