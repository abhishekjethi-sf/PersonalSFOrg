/*
	Pass params when controller is different
	1) Pass params in URL and Pass as a String (JSON) to VF Page 2
	2) Disable button for System Admin	
*/
public class PassParamDiffCtrl1 {
	
	public String str1{get;set;}
	public String str2{get;set;}
	public Boolean bVisible{get;set;}
	public Boolean btnDisabled{get;set;}
	private Id currentUserProfileId;
	
	public PassParamDiffCtrl1(){
		bVisible = false;
		btnDisabled = false;
		currentUserProfileId = UserInfo.getProfileId();
		
		map<Id,Profile> profileMap = new map<Id,Profile>([SELECT Id FROM Profile WHERE Name IN ('Custom Admin','System Administrator')]);
		btnDisabled = profileMap.containsKey(currentUserProfileId) ? true : false;
	}
	
    public PageReference display(){
    	
    	JSONGenerator gen = JSON.createGenerator(true);
    	gen.writeStartObject();
	        gen.writeStringField('string1', str1);         
	        gen.writeStringField('string2', str2);
	        gen.writeBooleanField('checkbox', bVisible);
	    gen.writeEndObject();
    	String finalJSON = gen.getAsString();
		    	
    	PageReference pageRef = new PageReference('/apex/PassParamDiffCtrlPage2');
    	pageRef.getParameters().put('jsonData', finalJSON);
    	pageRef.setRedirect(true);
    	return pageRef;
    }	
}