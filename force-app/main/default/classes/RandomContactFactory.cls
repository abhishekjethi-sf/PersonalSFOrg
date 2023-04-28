public class RandomContactFactory {
	
	// Get all the Contacts
	public static list<Contact> generateRandomContacts(Integer numContacts, String lastName){
		list<Contact> conList = new list<Contact>();
		for(Integer i = 1; i<=numContacts; i++){
			Contact con = new Contact(FirstName = 'Test '+i,LastName = lastName , Email = 'test@test.com');
			conList.add(con);
		}
		return conList;
	}
}