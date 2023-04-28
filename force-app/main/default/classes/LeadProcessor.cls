global class LeadProcessor implements Database.Batchable<sObject>{
	
	//START Method
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('SELECT LeadSource FROM Lead');
	}
	
	// EXECUTE Method
	global void execute(Database.BatchableContext bc, list<Lead> scope){
		for(Lead lead : scope){
			lead.LeadSource = 'Dreamforce';
		}
		update scope;
	}
    
    // FINISH Method
    global void finish(Database.BatchableContext bc){
    	
    }
}