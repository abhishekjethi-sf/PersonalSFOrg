public class createContactUsingApexCtrl {
	
    @AuraEnabled
    public static String insertContact(String fName,String lName){
        Contact contact = new Contact(FirstName = fName, LastName = lName);
        insert contact;
        return contact.Id;
    }
}