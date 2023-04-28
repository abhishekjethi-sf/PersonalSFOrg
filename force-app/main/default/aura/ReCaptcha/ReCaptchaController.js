({
    doInit: function (cmp, evt, helper){
        let vfOrigin = "https://abhisheklightningchamp-dev-ed--c.ap5.visual.force.com";
        window.addEventListener("message", function(event) {
            console.log('*********'+JSON.stringify(event.data));
            if (event.origin !== vfOrigin) {
                // Not the expected origin: Reject the message!
                console.log('######error###');
                return;
            } 
            if (event.data==="Unlock"){            	
              let myButton = cmp.find("myButton");
                myButton.set('v.disabled', false);
            }            
        }, false);                
    },
    doSubmit: function (cmp, evt, helper){
        alert("Do Submit");
    }
    
})