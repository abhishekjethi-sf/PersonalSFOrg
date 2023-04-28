/*
   Apex Class
*/
public class AccountHandler {
    // Insert Account
    public static Account insertNewAccount(String accName){
        Account acc = new Account(Name = accName);
        try{
            insert acc;
            return acc;
        }
        catch(DMLException e){
            return null;
        }
    }
}