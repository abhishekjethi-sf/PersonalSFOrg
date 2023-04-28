public class AccountsController {
      @AuraEnabled
      public static List <Account> getAccounts() {
        return [SELECT Name, Industry, Type, NumberOfEmployees, TickerSymbol, Phone FROM Account ORDER BY CreatedDate ASC];
      }
}