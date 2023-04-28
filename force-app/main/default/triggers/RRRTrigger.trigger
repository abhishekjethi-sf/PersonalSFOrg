/*
	Trigger to give access to record to FIL and RXP User
*/
trigger RRRTrigger on RRR__c (after insert) {

	//Add entries to RRR__Share object
	list<RRR__Share> rrShareList = new list<RRR__Share>();

	//RRR__Share rxpUser;
	//RRR__Share filUser;

	for(RRR__c rrrRecord : trigger.new){

		RRR__Share rxpUser = new RRR__Share();
		RRR__Share filUser = new RRR__Share();

		// RXP User
		if(!String.isBlank(rrrRecord.RXP_User__c)){
			
			rxpUser.ParentId = rrrRecord.Id;
			rxpUser.AccessLevel = 'Read';
			rxpUser.UserOrGroupId = rrrRecord.RXP_User__c;
			rxpUser.RowCause = Schema.RRR__Share.RowCause.RXPUser__c;
			rrShareList.add(rxpUser);
		}

		// FIL User
		if(!String.isBlank(rrrRecord.RXP_User__c)){
			filUser.ParentId = rrrRecord.Id;	
			filUser.AccessLevel = 'Edit';
			filUser.UserOrGroupId = rrrRecord.FIL_User__c;
			filUser.RowCause = Schema.RRR__Share.RowCause.FILUser__c;	
			rrShareList.add(filUser);	
		}
	}

	if(!rrShareList.isEmpty()){
		insert rrShareList;
	}

}