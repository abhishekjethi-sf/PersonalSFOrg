public class ApplicationDetailsCtrl {

    @AuraEnabled
    public static IdentityTypeWrapper getRelevantIdentityFields(String selectedIdentityType){
        system.debug('####selectedIdentityType####'+selectedIdentityType);
        // Get the Data from Custom Metadata
        if(String.isNotBlank(selectedIdentityType)){
            ApplicationInformation__mdt applicationTypeRecord = [SELECT Type_of_Identity__c, Mandatory__c, Optional__c 
                                                                 FROM ApplicationInformation__mdt WHERE Type_of_Identity__c =: selectedIdentityType LIMIT 1];
            system.debug('######applicationTypeRecord###'+applicationTypeRecord);
            
            if(applicationTypeRecord != null){
                IdentityTypeWrapper wrapperDetails = new IdentityTypeWrapper();
                wrapperDetails.identityType = applicationTypeRecord.Type_of_Identity__c;
                // Check required fields
                if(String.isNotBlank(applicationTypeRecord.Mandatory__c)){
                    list<String> mandatoryFields = applicationTypeRecord.Mandatory__c.split(';');
                    for(String eachMandatoryField : mandatoryFields){
                        wrapperDetails.requiredFields.put(eachMandatoryField,true);
                        wrapperDetails.fieldsToShow.put(eachMandatoryField,true);
                    }
                }
                // Check optional fields
                if(String.isNotBlank(applicationTypeRecord.Optional__c)){
                    list<String> optionalFields = applicationTypeRecord.Optional__c.split(';');
                    for(String eachOptionalField : optionalFields){
                        wrapperDetails.fieldsToShow.put(eachOptionalField,true);
                    }
                }    
                return wrapperDetails;
            }
            return null;
        }
        return null;
    }
    
    // Wrapper class
    public class IdentityTypeWrapper{
        
        @AuraEnabled
        public String identityType {get; set;}
        @AuraEnabled
        public Map<String, Boolean> fieldsToShow {get; set;}        
        @AuraEnabled
        public Map<String, Boolean> requiredFields {get; set;}         
        
        public IdentityTypeWrapper () {
            fieldsToShow = new Map<String, Boolean> ();
            requiredFields = new Map<String, Boolean> ();
        }        
    }
}