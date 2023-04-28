({
    showHideSpinner : function(component) {
        var showValue = component.get("v.show");
        var spinner = component.find("spinner"); // Find the component with Aura Id as spinner
        if(showValue) {
            $A.util.removeClass(spinner, "slds-hide");
        } else {
            $A.util.addClass(spinner, "slds-hide");
        }
    }
})