({
    
    doInit : function(component,event,helper){
    // Set the columns    
    component.set('v.mycolumns', [
                {label: 'Account Id', fieldName: 'Id', type: 'Id'},
                {label: 'Account Name', fieldName: 'Name', type: 'text'},
                {label: 'Account Site', fieldName: 'Site', type: 'text'}
            ]);        
     	// Step 1
        var action = component.get("c.getAccounts");
        
        // Step 2
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === 'SUCCESS'){
                // Get the data from DB
                component.set("v.mydata",response.getReturnValue());
            } else if (state === 'ERROR'){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }else{
                console.log('Something went wrong, Please check with your admin');
            }              
        });
        // Step 3 - Fire Action
        $A.enqueueAction(action);        
    },
       
    createAccount : function(component,event,helper){
        helper.createAcc(component);
    }
})