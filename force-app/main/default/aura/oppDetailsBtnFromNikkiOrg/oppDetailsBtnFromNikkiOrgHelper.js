({
    getDataFromNikkiOrg : function(component,helper) {
        // Step 1: Create the server side action
        var action = component.get("c.getOppDetails"); 
        // Step 2: Pass the paramaters
        action.setParams({
            "opportunityId" : component.get("v.recordId")
        });
        // Step 4: Implement the callback action
        action.setCallback(this, function(response){
              var state = response.getState();             
			  if (state === "SUCCESS") {
                  console.log("####JSON data###"+JSON.stringify(response.getReturnValue())); // Get the JSON Output
                  console.log("####data###"+response.getReturnValue()); // Get the logs in object level format
                  helper.getOppDetailsFromSFDCSystem(component,helper,response.getReturnValue());
              }
              else {
                  console.log("####errors###"+response.getErrors());  
              }
        });
        // Step 3: Enqueue the action
        $A.enqueueAction(action);
    },
    
    // Get the Opportunity Information
    getOppDetailsFromSFDCSystem : function(component,helper,opportunity){
        // Step 1: Create the action
        var action = component.get("c.webServiceCallout");
        // Step2 : Pass the paramaters
        action.setParams({
            "oppSAPRecordId" : opportunity.SAP_Record_Id__c
        });
        // Step 4: Implement the callback action
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                console.log("####JSON data###"+JSON.stringify(response.getReturnValue())); // Get the JSON Output
                // Parsing JSON string into JS object to show in the output
                //https://www.sfdcstop.com/2019/01/salesforce-lightning-tutorial-part-6.html
                var responseObj = JSON.parse(response.getReturnValue());
                console.log("####responseObj###"+responseObj); // Get the responseObj Output
                // Set the opporutnity values
                component.set("v.oppDetails",responseObj.records);   
                component.set("v.btnClicked",true);
            }
        });
        // Step 3: Enqueue the action
        $A.enqueueAction(action);
    }
})