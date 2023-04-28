trigger AccountTrigger on Account (after update) {
    
    // Update the same record in after trigger
    if(checkRecursive.isFirstTime){
        list<Account> updatedAccList = new list<Account>();
        for(Account acc : trigger.newMap.values()){
            Account a = new Account(Id = acc.Id,Description = 'Test Description');
            updatedAccList.add(a);
        }
        checkRecursive.isFirstTime = false;
        update updatedAccList;
    }
}