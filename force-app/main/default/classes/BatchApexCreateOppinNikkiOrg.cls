/*
    Batch apex callout to send Opp and Opp line information to Nikki Org
*/
public class BatchApexCreateOppinNikkiOrg implements Database.Batchable<sObject>, Database.Stateful,Database.AllowsCallouts{
    //https://developer.salesforce.com/forums/?id=9060G000000BdVjQAK
    //https://salesforce.stackexchange.com/questions/103587/batch-code-doesnt-update-record
    // Get all the Opps and its line items whose Processed Check is Transition or Error
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Name,Amount,StageName,(SELECT ListPrice,Name FROM OpportunityLineItems) FROM Opportunity WHERE Processed_Check__c IN (\'Transition\',\'Error\')');
    }

    // Execute the logic. Send the data to Nikki Org in JSON format
    public void execute(Database.BatchableContext bc, List<Opportunity> scope){
        // If the scope has some records, then send to Nikki Org
        if(!scope.isEmpty()){

            try{
                // Get the access token from REST Login Method (Username - Password OAuth2.0)
                String accessToken = SFLoginCls.getSessionIdFromHttpCallout(); 

                // Make JSON Body using JSON generator 
                //https://developer.salesforce.com/forums/?id=9060G000000BgMfQAK
                // Make JSON body using Wrapper class
                // JSON Body using JSON Serialize methods
                String jsonBody = JSON.serialize(scope);

                // Make a callout to send the Opp Details
                Http httpCallout = new Http();
                HttpRequest req = new HttpRequest();
                HttpResponse res = new HttpResponse();
                req.setHeader('Authorization', 'Bearer ' + accessToken);
                req.setHeader('Content-Type', 'application/json');
                req.setClientCertificateName('BatchApexCreateOppinNikkiOrg'); //If the external service requires a client certificate for authentication, set the certificate name            
                // Dummy endpoint. Need to create an Apex POST Webservice to send the data to Nikki Org
                req.setEndpoint('callout:NikkiOrg/services/data/v45.0/query/?q=SELECT+ID+FROM+Opportunity');
                req.setMethod('POST');
                req.setBody(jsonBody);
                req.setCompressed(true); // Compress the request if the webservice accepts compression else make it false
                
                res = httpCallout.send(req);
                // Process the response
                if(res.getStatusCode() == 201){
                    String responseJSON = res.getBody();
                    // Update the Opportunity Processed Check field
                    for(Opportunity opp : scope){
                        opp.Processed_Check__c = 'Processed';
                    }
                    update scope;                
                }
            }
            catch(Exception e){
                system.debug('An unexpected error occured: '+ e.getMessage());
            }
        }
    }

    public void finish(Database.BatchableContext bc){}
}
/*
JSON output
{  
   "DataSetName":"GetOpportunities",
   "Data":[  
      {  
         "OppName":"TestOpp",
         "OppAmount":"20000",
         "OppStage":"Closed - Won",
         "OppProducts":[  
         ]
      },
      {  
         "OppName":"TestOpp",
         "OppAmount":"20000",
         "OppStage":"Closed - Won",
         "OppProducts":[  
            {  
               "ListPrice":"1000",
               "Name":"AJ User # 1"
            },
            {  
               "ListPrice":"1000",
               "Name":"AJ User # 1"
            }
         ]
      },
      {  
         "OppName":"TestOpp",
         "OppAmount":"20000",
         "OppStage":"Closed - Won",
         "OppProducts":[   
            {  
               "ListPrice":"1000",
               "Name":"AJ User # 1"
            },
            {  
               "ListPrice":"1000",
               "Name":"AJ User # 1"
            }
         ]
      }
   ]
}
*/
/************************
Standard JSON Output for running the query
list<Opportunity> oppList = [SELECT Name,StageName,Amount,(SELECT ListPrice,Name FROM OpportunityLineItems) From Opportunity WHERE Processed_Check__c = 'Transition'];
String JSONData = JSON.serialize(oppList);
system.debug(JSONData);
[  
   {  
      "attributes":{  
         "type":"Opportunity",
         "url":"/services/data/v45.0/sobjects/Opportunity/0067F00000OSvKbQAL"
      },
      "Name":"Test Opp - 1",
      "StageName":"Prospecting",
      "Amount":175000.00,
      "Id":"0067F00000OSvKbQAL",
      "OpportunityLineItems":{  
         "totalSize":2,
         "done":true,
         "records":[  
            {  
               "attributes":{  
                  "type":"OpportunityLineItem",
                  "url":"/services/data/v45.0/sobjects/OpportunityLineItem/00k7F000010mQtnQAE"
               },
               "OpportunityId":"0067F00000OSvKbQAL",
               "Id":"00k7F000010mQtnQAE",
               "ListPrice":100000.00,
               "Name":"Test Opp - 1 GenWatt Diesel 1000kW"
            },
            {  
               "attributes":{  
                  "type":"OpportunityLineItem",
                  "url":"/services/data/v45.0/sobjects/OpportunityLineItem/00k7F000010mQtsQAE"
               },
               "OpportunityId":"0067F00000OSvKbQAL",
               "Id":"00k7F000010mQtsQAE",
               "ListPrice":25000.00,
               "Name":"Test Opp - 1 GenWatt Diesel 200kW"
            }
         ]
      }
   },
   {  
      "attributes":{  
         "type":"Opportunity",
         "url":"/services/data/v45.0/sobjects/Opportunity/0067F00000OSvLoQAL"
      },
      "Name":"Test Opp - 2",
      "StageName":"Value Proposition",
      "Amount":10000.00,
      "Id":"0067F00000OSvLoQAL"
   },
   {  
      "attributes":{  
         "type":"Opportunity",
         "url":"/services/data/v45.0/sobjects/Opportunity/0067F00000OSvLtQAL"
      },
      "Name":"Test Opp - 3",
      "StageName":"Perception Analysis",
      "Amount":100000.00,
      "Id":"0067F00000OSvLtQAL",
      "OpportunityLineItems":{  
         "totalSize":1,
         "done":true,
         "records":[  
            {  
               "attributes":{  
                  "type":"OpportunityLineItem",
                  "url":"/services/data/v45.0/sobjects/OpportunityLineItem/00k7F000010mQtxQAE"
               },
               "OpportunityId":"0067F00000OSvLtQAL",
               "Id":"00k7F000010mQtxQAE",
               "ListPrice":100000.00,
               "Name":"Test Opp - 3 GenWatt Diesel 1000kW"
            }
         ]
      }
   }
]
************************/