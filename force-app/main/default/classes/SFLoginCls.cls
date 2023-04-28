/*
	Class to login to destination org (Nikki Org)
	http://ashishsharmadevsfdc.blogspot.com/2014/08/a-quick-salesforce-oauth-20-usage.html
	https://www.jitendrazaa.com/blog/salesforce/getting-record-from-one-salesforce-organization-to-other/
	
	You need to use the correct Salesforce OAuth endpoint when issuing authentication requests in your application. The primary OAuth endpoints are:
		For authorization: https://login.salesforce.com/services/oauth2/authorize
		For token requests: https://login.salesforce.com/services/oauth2/token
		For revoking OAuth tokens: https://login.salesforce.com/services/oauth2/revoke	
		
		Tokens  : OAuth 2.0 understands the language of tokens, Let's simplify tokens here.

		1. Authorization Code:- It is a short lived token used to get acess token and refersh token.
		2. Acess Token:-This is the token we are looking for .It has a longer lifetime than AuthorizationCode.
		3. Refresh Token:- It has indefinite lifetime ,This can be used to get fresh acess token once acess token gets expires.
		
		We got two main important parameters in connected app ,once it gets save.
		a. client key
		b. client secret
		
		There are two concepts of security where above parameters helps.
		1. Authentication: Users are authenticated to what they say they are.(Through Client Id and Client Secret  )
		2. Authorization:- Apps are authorized to access resource.(Through Access Token).				
*/
public class SFLoginCls {

	// Get Session Id using Custom Metadata Type using SOAP Login
	public static String getSessionIdFromSOAPCallout(){

		IntegrationDetails__mdt nikkiOrg = [SELECT Username__c,Password__c,NS_SOAP__c,NS_SF__c FROM IntegrationDetails__mdt WHERE DeveloperName = 'NikitaOrgSOAP' LIMIT 1];
		
		HttpRequest req = new HttpRequest();
		req.setMethod('POST');   
		req.setEndpoint('https://ap5.salesforce.com/services/Soap/u/43.0');
		req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
		req.setHeader('SOAPAction', 'create');
		req.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' + nikkiOrg.Username__c + '</username><password>' + nikkiOrg.Password__c + '</password></login></Body></Envelope>');
		
		HttpResponse res =  new Http().send(req);
		Dom.Document responseDocument = res.getBodyDocument();
		Dom.Xmlnode rootElm = responseDocument.getRootElement(); // soapenv:Envelope
		Dom.Xmlnode bodyElm = rootElm.getChildElement('Body', nikkiOrg.NS_SOAP__c); // soapenv:Body 
		Dom.Xmlnode loginResponseElm = bodyElm.getChildElement('loginResponse', nikkiOrg.NS_SF__c); // loginResponse
		Dom.Xmlnode resultElm = loginResponseElm.getChildElement('result', nikkiOrg.NS_SF__c); // result
		Dom.Xmlnode sessionIdElm = resultElm.getChildElement('sessionId', nikkiOrg.NS_SF__c); // sessionId
		String SERVER_URL = resultElm.getChildElement('serverUrl', 'urn:partner.soap.sforce.com') .getText().split('/services')[0];
		String SESSION_ID = resultElm.getChildElement('sessionId', 'urn:partner.soap.sforce.com') .getText();
		return SESSION_ID;
	}
	
	// Get Session Id using Custom Metadata Type using OAuth2.0 Username-password method
	public static String getSessionIdFromHttpCallout(){
		IntegrationDetails__mdt nikkiOrg = [SELECT Username__c,Password__c,Customer_Secret__c,Client_Id__c FROM IntegrationDetails__mdt WHERE DeveloperName = 'NikitaOrgRESTOAuth2' LIMIT 1];
        String requestbody = 'grant_type=password&client_id=' + nikkiOrg.Client_Id__c + '&client_secret=' + nikkiOrg.Customer_Secret__c + '&username=' + nikkiOrg.Username__c + '&password=' + nikkiOrg.Password__c; 
        //String requestbody='{"grant_type":"password","client_id":'+nikkiOrg.Client_Id__c+',"client_secret":'+nikkiOrg.Customer_Secret__c+',"username":'+nikkiOrg.Username__c+',"password":'+nikkiOrg.Password__c+'}';
        
        // Make a callout
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setBody(requestbody);
        request.setMethod('POST');
        request.setEndpoint('callout:NikkiOrg/services/oauth2/token'); // Get the URL

        HttpResponse response = http.send(request);
        
        // Get the access token from the JSON response
        deserializeAOuthUserNamePasswordResponse deserializedResponse = (deserializeAOuthUserNamePasswordResponse) JSON.deserialize(response.getBody(), deserializeAOuthUserNamePasswordResponse.class);
        return deserializedResponse.access_token;
	}	
	
	// Response from OAUTH Username -Password Flow
    private class deserializeAOuthUserNamePasswordResponse {
        public String id;
        public String access_token;
        public String instance_url;
        public String issued_at;
        public String signature;
    }	
}