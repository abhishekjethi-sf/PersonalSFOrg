/*
	Web Server Flow Controller oAuth2.0
	https://community.boomi.com/docs/DOC-2551
	https://help.salesforce.com/articleView?id=remoteaccess_authenticate_overview.htm
	
	First get the authorisation code, then with the code get the access token and refresh token
*/
public class aouthWebserverFlowController {

    public String Dev2OrgAccountMetaData {get;set;}
    public String oAuthCode {get;set;}
    
    public String getFullURL() {
        return fullURL;
    }

    String baseUrl = 'https://login.salesforce.com/services/oauth2/authorize';
    String clientId = '&client_id=3MVG9d8..z.hDcPKQ.1IGv2FoNgL.Ql2LyOYwdGUsxJTlloASpeTX_N1C0ikbNQYXK6SQ5bGsyvYepe3OZC9W';
    String responseType = '?response_type=code';
    String redirectURI = '&redirect_uri=https://c.ap1.visual.force.com/apex/aouthWebServerFlow';
    String clientSecret = '&client_secret=5376914243062705662';
    String fullURL = baseUrl + responseType + clientId + redirectURI;
    String baseTokenURL = 'https://login.salesforce.com/services/oauth2/token';
    
    public string uRLToGetAccessToken {get;set;}
    public string accessToken {get;set;}

    public aouthWebserverFlowController() {
    	oAuthCode = 'test';
        if (ApexPages.currentPage().getParameters().get('code') != null) {
            oAuthCode = ApexPages.currentPage().getParameters().get('code');
            string codeURL = '?code=' + oAuthCode + '&grant_type=authorization_code';
            uRLToGetAccessToken = baseTokenURL + codeURL + clientId + clientSecret + redirectURI;
        }
            system.debug('##########uRLToGetAccessToken###########'+uRLToGetAccessToken);
            system.debug('##########FullURL###########'+FullURL);        
    }
    
    JSONWrapper jsonWrapObj;
    
    // Call this method to get access token 
    public void getAccessToken() {
        //Callout to get Access Token
        Http h = new Http();
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        req.setEndpoint(uRLToGetAccessToken);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        system.debug('##############' + res.getBody());

        jsonWrapObj = (JSONWrapper) JSON.deserialize(res.getBody(), JSONWrapper.class);
        accessToken = jsonWrapObj.access_token;
        system.debug('###########accessToken########' + accessToken);
    }
    
    // Call this method to get Dev2 org account metadata
    public void getAnotherOrgAccountMetadata() {
        String restResourceURL = 'https://ap5.salesforce.com/services/data/v20.0/sobjects/Account/describe';
        String fullRestUrl = restResourceURL;
        
        Http h1 = new Http();
        HttpRequest req1 = new HttpRequest();
        req1.setEndpoint(fullRestUrl);

        req1.setHeader('Authorization', 'Bearer ' + accessToken);
        req1.setMethod('GET');
        
        // Send the request, and return a response
        HttpResponse res1 = h1.send(req1);
        system.debug('##################' + res1.getBody());
        Dev2OrgAccountMetaData = res1.getBody();
    }

    //Wrapper to store acecss token
    public class JSONWrapper {
        public Integer expires_in;
        public String access_token;
    }
}