@isTest
private class AddPrimaryContactTest {

    @isTest static void createContacts() {
		list<Account> accList = new list<Account>();
		for(Integer i = 1;i<= 50;i++){
			accList.add(new Account(Name = 'Test Account ' + i, BillingState = 'NY'));
		}
		
		for(Integer j = 1;j<= 50;j++){
			accList.add(new Account(Name = 'Test Account ' + j, BillingState = 'CA'));
		}		
		insert accList;
		
		Contact contact = new Contact(LastName = 'Test User');
		insert contact;
		
		Test.startTest();
			Id JobId = system.enqueueJob(new AddPrimaryContact(contact,'CA'));
		Test.stopTest();
		
		list<Contact> conList = [SELECT Id FROM Contact];
		//system.assertEquals(51,conList.size());
    }
}