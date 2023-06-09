public class AddPrimaryContact implements Queueable {
 	
 	private Contact contact;
 	private String billingState;
 	
 	//Constructor
 	public AddPrimaryContact(Contact conRecord, String state){
 		this.contact = conRecord;
 		this.billingState = state;
 	}
 	
	// Execute method - Dummy comment
 	public void execute(QueueableContext context) {
			// 16th May Release change
			// 16th May Release bugfix
 		list<Account> accList = [SELECT Id FROM Account WHERE BillingState =: billingState LIMIT 200];
 		list<Contact> conList = new list<Contact>();
 		
 		for(Integer i = 0; i<accList.size();i++){
 			Contact con = contact.clone(false,false,false,false);
 			con.AccountId = accList[i].Id;
 			conList.add(con);
 		}
 		
		// Inserting the contact list
 		if(!conList.isEmpty()){
 			insert conList;
 		}
 	}   
}
