public class AccountController {
    
    // Added commnts
    @AuraEnabled
    public static list<Account> getAccounts(){
        String soqlQuery = 'SELECT Id, Name,Site FROM Account';
        list<Account> accData = Database.query(soqlQuery);
        return accData;
    }
    
    // Added commnts
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Name, AnnualRevenue, Industry FROM Account WITH SECURITY_ENFORCED ORDER BY Name];
    }
}