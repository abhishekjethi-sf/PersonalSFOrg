public class AccountProcessor {
	
	@future
	public static void countContacts(list<Id> accountIds){
		
		list<Account> accList = [SELECT Number_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN: accountIds];
		for(Account acc : accList){
			acc.Number_of_Contacts__c = acc.Contacts.size();
		}
		update accList;
	}
}