({
    doInit : function(component, event, helper) {
        var opts = [
            { value: "License", label: "License" },
            { value: "Passport", label: "Passport" },
            { value: "Visa", label: "Visa" }
        ];
        component.set("v.options", opts);		
    },
    
    onchangeTypeofIdentity : function(component,event,helper){
        helper.onchangeTypeofIdentityHelper(component,event,helper);
    }
})