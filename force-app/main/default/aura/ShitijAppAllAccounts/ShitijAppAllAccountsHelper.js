({
    getAccountDetails : function(component) {
        // Call the Server side function to get the Accounts
        // Step 1: Create the action
        var action = component.get("c.getAllAccounts");
        // Step 4: Implement the callback action
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                // Set the account values
                console.log(response.getReturnValue());
                component.set("v.accounts",response.getReturnValue());   
            }
        });
        // Step 3: Enqueue the action
        $A.enqueueAction(action);       
    }
})