public with sharing class oppIntegrationtoNikkiOrgCls {

    @AuraEnabled(cacheable=true)
    public static Opportunity getOppDetails(String opportunityId){
        return [SELECT Id,SAP_Record_Id__c FROM Opportunity WHERE Id=: opportunityId];
    }
    
    @AuraEnabled(cacheable=true)
    public static String webServiceCallout(String oppSAPRecordId){
    	// Get the access token from REST Login Method (Username - Password OAuth2.0)
		String accessToken = SFLoginCls.getSessionIdFromHttpCallout(); 	
        
        if(!String.isEmpty(accessToken)){
            list<OpportunityColumnsinSAP__mdt> allOppColumns = [SELECT Column_Label__c,API_Name__c 
                                                                FROM OpportunityColumnsinSAP__mdt WHERE Active__c = true];
            String endpoint = 'callout:NikkiOrg/services/data/v45.0/query/?q=SELECT+';
            // Get the API Names
            for(OpportunityColumnsinSAP__mdt eachColumn : allOppColumns){
                endpoint += eachColumn.API_Name__c +',';
            }
            endpoint = endpoint.removeEnd(','); 
            endpoint += '+FROM+Opportunity+WHERE+SAP_Record_Id__c+=+' + '\'' + String.escapeSingleQuotes(oppSAPRecordId) + '\''; // Avoid SOQL Injection
            
            // Make a callout to get the Opp Details
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setHeader('Authorization', 'Bearer ' + accessToken);
            req.setHeader('Content-Type', 'application/json');
            req.setMethod('GET');
            req.setEndpoint(endpoint);
            
            HttpResponse response = h.send(req);
            system.debug('#####response#####'+response);
            system.debug('#####response.getBody()#####'+response.getBody());   
            return response.getBody();
        }
        else{
            return '';
        }
    }
    
   
}
/*** RESPONSE JSON From Nikki Org****
{  
   "totalSize":1,
   "done":true,
   "records":[  
      {  
         "attributes":{  
            "type":"Opportunity",
            "url":"/services/data/v45.0/sobjects/Opportunity/0067F00000CR9FKQA1"
         },
         "Type":"Existing Customer - Upgrade",
         "CloseDate":"2018-04-30",
         "Name":"GenePoint SLA",
         "Amount":30000.0,
         "StageName":"Closed Won"
      }
   ]
}
*************************************/