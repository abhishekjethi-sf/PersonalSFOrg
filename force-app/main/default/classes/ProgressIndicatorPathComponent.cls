public class ProgressIndicatorPathComponent {

    @AuraEnabled
    public static CasePathWrapper getCaseDataFromServer(String caseId){
        // Initialize the wrapper
        CasePathWrapper caseWrapperRecord = new CasePathWrapper();
        // Get the case details
        Case caseRecord = [SELECT Status,RecordType.Name FROM Case WHERE Id =:caseId]; 
        // Fetch the data from metadata type
        list<ProgressIndicator__mdt> progressIndicatorList = [SELECT Label__c,Status__c,Step_Number__c FROM ProgressIndicator__mdt WHERE Report_Type__c =:caseRecord.RecordType.Name];
        // Initialise the wrapper map
        caseWrapperRecord.stepDataMap = new map<Decimal,String>(); 
        
        //Loop through the Metadata
        for(ProgressIndicator__mdt progressIndicatorRecord : progressIndicatorList){
           	caseWrapperRecord.stepDataMap.put(progressIndicatorRecord.Step_Number__c,progressIndicatorRecord.Label__c);
            // Get the current step
            if(caseRecord.Status == progressIndicatorRecord.Status__c){
                caseWrapperRecord.currentStep = String.valueof(progressIndicatorRecord.Step_Number__c);
            }
        }
        return caseWrapperRecord;
    }    

   // wrapper class 
    public class CasePathWrapper{
        @AuraEnabled
        public String currentStep;
        @AuraEnabled
        public map<Decimal,String> stepDataMap;
    }    
}