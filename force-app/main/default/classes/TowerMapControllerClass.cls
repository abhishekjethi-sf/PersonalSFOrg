public with sharing class TowerMapControllerClass {
     @AuraEnabled
     public static List<Tower__c> getAllTowers() {
          String theObject = 'Tower__c';
          List<String> theFields = new List<String>{'Id', 'Name', 'State__r.Name', 'Tower_Location__Latitude__s', 'Tower_Location__Longitude__s'};
          String theFilter = '';
          String sortField = 'Name';
          String sortOrder = 'ASC';
          system.debug('###1111###');
          List<Tower__c> allTowers = TowerMapUtilClass.queryObjects(theObject, theFields, theFilter, sortField, sortOrder);
          return allTowers;
     }
}