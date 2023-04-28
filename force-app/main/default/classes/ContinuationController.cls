/*
    Continuation Controller class for VF-ContinuationPage
*/
public with sharing class ContinuationController {
    // Unique label corresponding to the continuation
    public String requestLabel;
    // Result of callout
    public String result {get;set;}
    // Callout endpoint as a named credential URL 
    // or, as shown here, as the long-running service URL
    private static final String LONG_RUNNING_SERVICE_URL = 'callout:NikkiOrg/services/data/v45.0/query/?q=SELECT+Id+FROM+Opportunity';
   
   // Action method
    public Object startRequest() {
        // Get the access token from REST Login Method (Username - Password OAuth2.0)
        String accessToken = SFLoginCls.getSessionIdFromHttpCallout();
        system.debug('#####accessToken####'+accessToken);

        // Create continuation with a timeout
        Continuation con = new Continuation(60);
        // Set callback method
        con.continuationMethod='processResponse';
        
        // Create  the standard callout request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(LONG_RUNNING_SERVICE_URL);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');      

        // Add callout request to continuation
        this.requestLabel = con.addHttpRequest(req);
        system.debug('#####this.requestLabel####'+this.requestLabel);
        // Return the continuation
        return con;  
    }
    
    // Callback method 
    public Object processResponse() {   
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse(this.requestLabel);
      // Set the result variable that is displayed on the Visualforce page
      this.result = response.getBody();
      system.debug('#####response.getBody()#####'+response.getBody());
      // Return null to re-render the original Visualforce page
      return null;
    }
}