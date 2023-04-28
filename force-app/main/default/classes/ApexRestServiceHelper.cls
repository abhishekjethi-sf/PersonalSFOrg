public with sharing class ApexRestServiceHelper {
    
    //Insert Contacts
    public static void insertContacts(String jsonBody){
    	// Process the data
    	system.debug('######jsonBody#######'+jsonBody);
    	ApexRestServiceRequest JSONData = (ApexRestServiceRequest)JSON.deserialize(jsonBody,ApexRestServiceRequest.class);
    	system.debug('######JSONData#######'+JSONData);
    	
    	list<Contact> contactList = new list<Contact>();
    	for(ApexRestServiceRequest.ContactData conData : JSONData.Data){
    		contactList.add(new Contact(LastName = 'Test User',Email = conData.email,AccountId = '0017F00000aNszm'));
    	}
    	insert contactList;
    }
}