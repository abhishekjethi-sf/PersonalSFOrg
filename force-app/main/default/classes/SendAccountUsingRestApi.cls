/*
	POC for SFDC to SFDC Integration for creating Accounts
*/
public class SendAccountUsingRestApi {
    
	// Make a callout to create Accounts in destination system
    @future(callout = true)
    // Future methods will always be static and return void type
    public static void createAccount(String jsonBody) {
    	// Get the access token from SOAP Login Method
		//String accessToken = SFLoginCls.getSessionIdFromSOAPCallout();         
		
    	// Get the access token from REST Login Method (Username - Password OAuth2.0)
		String accessToken = SFLoginCls.getSessionIdFromHttpCallout(); 		
        
        if (accessToken != null) {
            String endPoint = 'https://ap5.salesforce.com/services/data/v44.0/sobjects/Account'; //Change "ap4" in url to your Target Org Instance 
            // Make a callout
            Http h2 = new Http();
            HttpRequest req2 = new HttpRequest();
            req2.setHeader('Authorization', 'Bearer ' + accessToken);
            req2.setHeader('Content-Type', 'application/json');
            req2.setHeader('accept', 'application/json');
            req2.setBody(jsonBody);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse response = h2.send(req2);
            system.debug('#####response#####'+response);
            system.debug('#####response.getBody()#####'+response.getBody());
        }
    }
}