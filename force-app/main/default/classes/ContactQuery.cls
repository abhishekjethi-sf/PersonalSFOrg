public class ContactQuery{
	
    public list<Contact> contactList{get; set;}
    public list<Account> accList{get; set;}
    
    public ContactQuery(){
    // Display Contact List	
    contactList = new list<Contact>();
       for (Contact c : [SELECT Name FROM Contact]){
           contactList.add(c);
       }
	// Display Account list
    accList = new list<Account>();
       for (Account c : [SELECT Name FROM Account]){
           accList.add(c);
       }
    }    
}