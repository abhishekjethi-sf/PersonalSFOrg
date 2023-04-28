/*
    Class for all the aura methods used in Shitij App Container and its components
*/
public with sharing class ShitijAppClass {

    // Get all the Accounts
    @AuraEnabled(cacheable = true)
    public static list<Account> getAllAccounts(){
        return [SELECT Name,AccountNumber,Owner.Name FROM Account ORDER BY CreatedDate ASC LIMIT 10];
    }

    // Get all the Contacts
    @AuraEnabled(cacheable = true)
    public static list<Contact> getAllContacts(String accountId){
        return [SELECT FirstName,LastName,Email FROM Contact WHERE AccountId =: accountId];
    }    

    // Get all the Opportunities
    @AuraEnabled(cacheable = true)
    public static list<Opportunity> getAllOpportunities(String accountId){
        return [SELECT Name,StageName,Amount FROM Opportunity WHERE AccountId =: accountId];
    }     
}