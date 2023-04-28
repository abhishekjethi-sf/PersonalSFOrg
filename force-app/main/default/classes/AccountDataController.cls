public class AccountDataController {
	
    @AuraEnabled
    public static list<Account> getAccounts(){
        return [SELECT Name,Site FROM Account];
    }
}