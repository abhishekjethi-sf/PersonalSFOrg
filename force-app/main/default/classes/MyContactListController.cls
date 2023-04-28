public with sharing class MyContactListController {
	@AuraEnabled
	public static list<Contact> getContacts(Id recordId){
		return [SELECT FirstName,LastName,Email,Phone FROM Contact WHERE AccountId =: recordId];
	}
}