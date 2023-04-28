public with sharing class GetContactsByRRServiceHelper {

    public virtual class RRBadException extends Exception {} // Custom exception class

    // Fetch all the Contact records for each RR
	public static Object getAllContacts(String rrName){
		// Get the Accounts Data
		list<Account> accountData = [SELECT AccountNumber, (SELECT FirstName,LastName,Email,CreatedDate,LastModifiedDate FROM Contacts) 
									 FROM Account WHERE Id IN (SELECT Account__c FROM RR_Acc__c WHERE RRR__r.Name =: rrName)];

		// Process the records							 
		if(accountData.isEmpty()){
			return new GetContactsByRRServiceErrorResponse('SUCCESS', 'The RouteCode does not have any Route Accounts in Salesforce".');
		}							 
		else{
			// Create a JSON body
	        //instantiate the generator
	        JSONGenerator gen = JSON.createGenerator(true);
	        gen.writeStartObject();
	        gen.writeStringField('DataSetName', 'GetRRContacts'); 
	        gen.writeFieldName('Data');
	        gen.writeStartArray();
	        //for each Account create a JSON object
	        for(Account acc: accountData){

	            gen.writeStartObject();
	            // If the Account Number is empty
	            if(!String.isBlank(acc.AccountNumber)){
	            	gen.writeStringField('CustomerNumber', acc.AccountNumber);   
	            }
	            else{
	            	gen.writeNullField('CustomerNumber');
	            }      
	            gen.writeFieldName('Contacts');
	            gen.writeStartArray();
	            	for(Contact con : acc.Contacts){
	            			gen.writeStartObject();
	            				gen.writeStringField('ContactId', con.Id);
			            		//gen.writeStringField('FirstName', con.FirstName); 
			            		gen.writeStringField('LastName', con.LastName);
			            		if(!String.isBlank(con.Email)){
			            			gen.writeStringField('Email', con.Email);
			            		} else{
			            			gen.writeNullField('Email');	
			            		}
			            		gen.writeDateTimeField('CreatedDate', con.CreatedDate);
			            		gen.writeDateTimeField('LastModifiedDate', con.LastModifiedDate);
		            		gen.writeEndObject(); 
	           		}
	           	gen.writeEndArray();	
	            gen.writeEndObject();
	        }
	        gen.writeEndArray();
	        gen.writeEndObject();

	        String accountsJSON = gen.getAsString();
	        system.debug('***********'+accountsJSON);	
	        GetContactsByRRServiceSuccessResponse response = (GetContactsByRRServiceSuccessResponse) JSON.deserialize(accountsJSON, GetContactsByRRServiceSuccessResponse.class);
	        system.debug('##########'+response);

	        return response;	
		}
	}	
}