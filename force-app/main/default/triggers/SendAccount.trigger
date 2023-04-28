/*
    Trigger to integrate SFDC to SFDC. Trigger to send the JSON of Account data for the method
*/
trigger SendAccount on Account(after insert) {
    
    list<Account> accList = [SELECT Name,Site FROM Account WHERE Id IN: trigger.new];
        //instantiate the generator
        JSONGenerator gen = JSON.createGenerator(true);
      //  gen.writeStartObject();
      //  gen.writeFieldName('Accounts');
      //  gen.writeStartArray();
        //for each Account create a JSON object
        for(Account acc: accList){
            gen.writeStartObject();
            gen.writeStringField('Name', acc.Name);         
            gen.writeStringField('Site', acc.Site);
            gen.writeEndObject();
        }
      //  gen.writeEndArray();
        //end of the parent JSON object
     //   gen.writeEndObject();
        String accountsJSON = gen.getAsString();
        system.debug('***********'+accountsJSON);
    //Perform the Callout and sending JSON of List of Accounts
    if(!System.isFuture() && !System.isBatch()){
        SendAccountUsingRestApi.createAccount(accountsJSON);
    }
}
/*
    public void runContactUpdates(list<Contact> triggernew){
        if (System.isFuture() || System.isBatch())
             runContactUpdatesNow(triggernew);
        else
            runContactUpdatesFuture((new map<Id, Contact>(triggernew)).keyset());
    }
    
    @Future
    public void runContactUpdatesFuture(set<Id> conids){
        runContactUpdatesNow([select Id, Name from Contact where Id in :conids]);
    }
    
    public void runContactUpdatesNow(list<Contact> triggernew){
        //do updates to contacts. Maybe update to database
    }
*/