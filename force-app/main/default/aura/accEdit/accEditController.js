({
    handleSaveRecord: function(component, event, helper) {
        // Save Method
        component.find("recordData").saveRecord($A.getCallback(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                console.log("Save completed successfully.");
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved."
                    });
                    resultsToast.fire();                
            } else if (saveResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                        if (saveResult.state === "ERROR") {
                        var errMsg = "";
                        // saveResult.error is an array of errors, 
                        // so collect all errors into one message
                        for (var i = 0; i < saveResult.error.length; i++) {
                            errMsg += saveResult.error[i].message + "\n";
                        }
                            cmp.set("v.recordSaveError", errMsg);
                        } else {
                            cmp.set("v.recordSaveError", "");
                        }
                console.log('Problem saving record, error: ' + JSON.stringify(saveResult.error));
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        }));}
})