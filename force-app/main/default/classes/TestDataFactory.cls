@isTest
public class TestDataFactory {
    public static list<Account> createAccountsWithOpps(Integer numAccts, Integer numOppsPerAcct) {
        list<Account> accts = new list<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }
        insert accts;
        
        list<Opportunity> opps = new list<Opportunity>();
        
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add opportunities
            for (Integer k=0;k<numOppsPerAcct;k++) {
                opps.add(new Opportunity(Name=acct.Name + ' Opportunity ' + k,StageName='Prospecting', CloseDate=System.today().addMonths(1), AccountId=acct.Id));
            }
        }
        // Insert all opportunities for all accounts.
        insert opps;
        return accts;
    }
}