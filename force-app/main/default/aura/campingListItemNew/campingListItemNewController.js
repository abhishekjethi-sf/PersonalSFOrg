({
    packItem : function(component, event,helper){
       // var btnClicked = event.getSource();
        let a = component.get("v.item");
        a.Packed__c = true;
        //component.set("v.disabled",true);
        component.set("v.item",a);
    }     
 
})