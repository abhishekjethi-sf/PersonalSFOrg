({
    getContactDetails : function(component,accRecId) {
        component.set('v.mycolumns', [
                {label: 'Contact Id', fieldName: 'Id', type: 'text'},
                {label: 'Contact First Name', fieldName: 'FirstName', type: 'text'},
                {label: 'Contact Email', fieldName: 'Email', type: 'text'}
        ]);
        // Step 1: Create the action
        var action = component.get("c.getAllContacts");
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
                    component.set("v.contacts",response.getReturnValue());
                } else {
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