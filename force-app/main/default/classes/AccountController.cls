public class AccountController {
    
      
    // Insert Account
    @AuraEnabled
    public static Account insertAccount(Account accData){
        accData.Name = accData.Name + String.valueof(system.now());
        insert accData;
        return accData;
    }
    
    @AuraEnabled
    public static list<Account> getAccounts(){
        String soqlQuery = 'SELECT Id, Name,Site FROM Account';
        list<Account> accData = Database.query(soqlQuery);
        return accData;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Name, AnnualRevenue, Industry FROM Account WITH SECURITY_ENFORCED ORDER BY Name];
    }
}