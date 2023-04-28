/*
	Pass params when controller is same	
*/
public class PassParamSameCtrl {
    
    public Date date1{get;set;}
    public Date date2{get;set;}
    public Date date3{get;set;}
    public Date date4{get;set;}
    
    public PageReference display(){
    	date3 = date1;
    	date4 = date2;
    	
    	PageReference pageRef = new PageReference('/apex/PassParamSameCtrlPage2');
    	//pageRef.getParameters().put('date1', String.valueOf(date1));
    	//pageRef.getParameters().put('date2', String.valueOf(date2));
    	//pageRef.setRedirect(true);
    	return pageRef;
    }
}