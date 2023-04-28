public class ContactSearch {
    public static list<Contact> searchForContacts(String lastName,String postcode){
    	return [SELECT Name FROM Contact WHERE LastName=: lastName AND MailingPostalCode =: postcode];
    }
}