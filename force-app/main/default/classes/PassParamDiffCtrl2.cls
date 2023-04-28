public class PassParamDiffCtrl2 {
    
    private String jsonData{get;set;}
    
    public PassParamDiffCtrl2(){
    	jsonData = ApexPages.currentPage().getParameters().get('jsonData');
    	system.debug('##########jsonData##########'+jsonData);
    	passDataToAnotherVFPage dataSet = (passDataToAnotherVFPage) JSON.deserialize(jsonData,passDataToAnotherVFPage.class);
    	system.debug('##########dataSet##########'+dataSet);
    }
    
    // JSON Class
    public class passDataToAnotherVFPage{
    	public String string1;
    	public String string2;
    	public Boolean checkbox;
    }    
}