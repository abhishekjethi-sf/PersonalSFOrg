({
	doInit : function(component, event, helper) {
		console.log('inside init JS method');
	},
    
    handleClick : function(component,event,helper){
        console.log('inside handleClick method');
       	window.open("/apex/NewVFPage?id="+'0037F00000qahNlQAI','_blank');
      
    }
})