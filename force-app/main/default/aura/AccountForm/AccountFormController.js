({
	doInit : function(component, event, helper) {
        // Set the columns
        component.set('v.columns', [
            {label: 'Account Id', fieldName: 'Id', type: 'Id'},
            {label: 'Account Name', fieldName: 'Name', type: 'text'},
            {label: 'Account Site', fieldName: 'Site', type: 'text'}
        ]);
        
		// Step 1 - Make remote call
        var action = component.get("c.getAccounts");
        // Step 2 - Enqueue Action
        $A.enqueueAction(action);
        // Step 3 - Setup call back
        action.setCallback(this,function(response){
              var state = response.getState();
            if(state === 'SUCCESS'){
                component.set("v.accounts",response.getReturnValue());
            }            
        });
        
	},
    
    refreshAccounts : function(component, event){
    	var accountUpdated = event.getParam("newAccRecord");
        console.log('####accountUpdated###'+JSON.stringify(accountUpdated));
    	var accts = component.get("v.accounts");
        console.log('####accts###'+JSON.stringify(accts));
    	accts.push(accountUpdated);
    	console.log('####accts###'+JSON.stringify(accts));
        component.set("v.accounts",accts);        
	}
})