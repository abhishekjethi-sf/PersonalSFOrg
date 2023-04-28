public class ContactAndLeadSearch {
    public static list<list< SObject>> searchContactsAndLeads(String fName){
    	String searchquery = 'FIND \'Smith\' IN ALL FIELDS RETURNING Contact(Id),Lead(Id)';
    	list<list< SObject>> results = search.query(searchquery);
    	return results;
    }
}