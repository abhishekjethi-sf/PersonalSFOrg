@RestResource(urlMapping = '/ContactService')
global with sharing class ApexRestService {
	// Service to test the authentication mechanism OAuth2
	@HttpPost
	global static void doPost(){
		
		RestRequest request = RestContext.request;
		RestResponse response = RestContext.response;
		response.addHeader('Content-Type', 'application/json'); // Adding JSON as Request Headers
		//Call the Service
		ApexRestServiceHelper.insertContacts(request.requestBody.toString());
	}
// End of class    
}