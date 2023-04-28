({
    afterFinish : function(component, event, helper) {
        //  Geting the list of uploaded files
        var uploadFiles = event.getParam("files");
        var strFileNames = '';
       
        // getting uploaded file names
        for(var i=0; i<uploadFiles.length; i++) {
            strFileNames += uploadFiles[i].name + ', ';
        }
        
        // Showing Success message
        component.find("notifLib").showToast({
            "variant": "success",
            "title": strFileNames,
            "message": uploadFiles.length + " Files are Uploaded Successfully!"
        });
        component.set("v.checkVisibility",false);
        $A.get("e.force:refreshView").fire();
    },
    
    save : function(component, event, helper) {
        var uploadFiles = event.getParam("files");
        if(uploadFiles == null || uploadFiles == "undefined"){
            component.set("v.checkVisibility",true);
            // Fire an event
            var appEvent = $A.get("e.c:LightningFileUploadEvent");
            appEvent.setParams({"filerrorMessage" : "Please upload a file !!"});
            appEvent.fire();            
        }
    },
    
    cancel : function(component, event, helper) {
        component.set("v.checkVisibility",false);
        $A.get("e.force:refreshView").fire();
    },

    handleFilesChange: function(component, event, helper) {
        //alert('fileselected');
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        //component.set("v.fileName", fileName);
        alert(fileName);
    }  
})