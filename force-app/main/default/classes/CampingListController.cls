public with sharing class CampingListController {
    
    @AuraEnabled
    public static list<Camping_Item__c> getItems(){
    	return [SELECT Name,Quantity__c,Price__c,Packed__c FROM Camping_Item__c];
    }
    
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c item){
    	insert item;
    	return item;
    }
}