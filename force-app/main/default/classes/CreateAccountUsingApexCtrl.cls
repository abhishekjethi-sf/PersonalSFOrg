public class CreateAccountUsingApexCtrl {
	
    @AuraEnabled
    public static void insertAccount(String accName,String accNumber, String accSite) {  
        Account acc = new Account();
        acc.Name = accName;
        acc.AccountNumber = accNumber;
        acc.Site = accSite;
        insert acc;
    }  
}