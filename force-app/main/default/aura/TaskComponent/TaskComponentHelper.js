({
    createAcc : function (component) {
        var newAcc = component.get("v.newAccount");
        // Step 1 - Create Remote call
        var action = component.get("c.insertAccount");
        // Pass parameters to the class method
        action.setParams({
            "accData" : newAcc
        });
        // Step 2 - Create Call back
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var accDataList = component.get("v.mydata");
                accDataList.push(response.getReturnValue());
                component.set("v.mydata",accDataList);    
                // Empty attribute of Account
                component.set("v.newAccount",{'sobjectType': 'Account','Name': '','Site': ''});
            }
        });         
        // Step 3 - Fire Action
        $A.enqueueAction(action);        
    }
})