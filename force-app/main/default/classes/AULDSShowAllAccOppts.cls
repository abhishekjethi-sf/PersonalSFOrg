public class AULDSShowAllAccOppts {

    @AuraEnabled
    public static list<Opportunity> getAllOppts(String accId){
        list<Opportunity> oppList = [SELECT Id,Name,StageName,Amount FROM Opportunity WHERE AccountId =: accId];
        return oppList;
    }
}