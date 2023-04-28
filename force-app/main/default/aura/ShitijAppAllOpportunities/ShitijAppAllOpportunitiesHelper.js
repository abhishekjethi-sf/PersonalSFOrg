({
    getOppDetails : function(component,accRecId) {
        component.set('v.mycolumns', [
            {label: 'Opp Id', fieldName: 'Id', type: 'text'},
            {label: 'Opp Name', fieldName: 'Name', type: 'text'},
            {label: 'Opp Stage', fieldName: 'StageName', type: 'text'},
            {label: 'Opp Amount', fieldName: 'Amount', type: 'number',typeAttributes: { minimumFractionDigits : '2' }}
        ]);

        // Step 1: Create the action
        var action = component.get("c.getAllOpportunities");
        // Step2 : Pass the paramaters
        action.setParams({
            "accountId" : accRecId
        });
        // Step 4: Implement the callback action
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                if(response.getReturnValue().length > 0){
                    component.set("v.checkVisibility",true);
                    // Set the contact values
                    component.set("v.opportunities",response.getReturnValue());   
                } else{
                    component.set("v.checkVisibility",false);
                }
            } else{
                component.set("v.checkVisibility",false);
            }
        });
        // Step 3: Enqueue the action
        $A.enqueueAction(action); 
    }
})