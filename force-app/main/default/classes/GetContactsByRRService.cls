/*
 REST Web Service to get the JSON structure
*/
@RestResource(urlMapping = '/ContactsByRR')
global with sharing class GetContactsByRRService {

    //Declare Variables    
    global static Object result;
    global static String jsonString {
        get {
            return JSON.serialize(result);
        }
        set;
    }

    // GET REST Method to get all Contacts
	@HttpGet
	global static void getContactsFromRRAccounts(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        response.addHeader('Content-Type', 'application/json'); // Adding JSON as Request Headers

        String rrName = request.params.get('routeCode'); // Get the Parameters
        system.debug('#####rrName#######'+rrName);

        // Execute the process
        try{
        	// If the parameter is empty in the Request URL
        	if(String.isBlank(rrName)){
        		 throw new GetContactsByRRServiceHelper.RRBadException('The RouteCode is empty in the request.');
        	} else{
        		result = GetContactsByRRServiceHelper.getAllContacts(rrName);
        	}
        }
        catch (GetContactsByRRServiceHelper.RRBadException exp){
            response.statusCode = 400;
            result = new GetContactsByRRServiceErrorResponse('BAD_REQUEST', exp.getMessage());
        } catch (Exception exp) {
            response.statusCode = 500;
            result = new GetContactsByRRServiceErrorResponse('ERROR', exp.getMessage());
        }

        //Setting Response to the method
        response.responseBody = Blob.valueOf(jsonString);        
	}

}