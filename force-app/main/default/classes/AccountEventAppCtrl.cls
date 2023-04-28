public class AccountEventAppCtrl {
    
    @AuraEnabled
    public static list<Account> getAccounts(){
        return [SELECT Id,Name,Site FROM Account ORDER BY CreatedDate DESC];
    }
    
    @AuraEnabled
    public static Account createAccRecord(Account acc){
        acc.Name = acc.Name +' - '+ String.valueOf(system.now());
        upsert acc;
        return acc;
    }
}