@isTest
private class AccountManagerTest {

	@TestSetup static void createData(){
		Account account = new Account(Name = 'Test Account');
		insert account;
		
		list<Contact> contactList = new list<Contact>();
		for(Integer i = 1;i<=5;i++){
			contactList.add(new Contact(LastName = 'Test User' + i,Email = 'test@test.com',AccountId = account.Id));
		}
		insert contactList;
	}

    @isTest static void getAccountDetails() {
     	Account account = [SELECT Id FROM Account WHERE Name = 'Test Account'];
     	system.debug('################'+account.Id);
        // Set up a test request
        RestRequest request = new RestRequest();
        //request.requestUri = 'https://abhisheklightningchamp-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + account.Id + '/contacts';
        request.requestUri = 'https://abhisheklightningchamp-dev-ed.my.salesforce.com/services/apexrest/AccountsTests/' + account.Id + '/contacts'; // Valdiating String replace POC
        system.debug('#######request.requestUri #########'+request.requestUri );
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account acc = AccountManager.getAccount();
        // Verify results
        system.assert(acc != null);
        system.assertEquals(5, acc.Contacts.size());     	   
    }
}