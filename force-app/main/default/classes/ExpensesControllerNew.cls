public with sharing class ExpensesControllerNew {
    // STERN LECTURE ABOUT WHAT'S MISSING HERE COMING SOON
    @AuraEnabled
    public static list<Expense__c> getExpenses() {
        return [SELECT Id, Name, Amount__c, Client__c, Date__c,Reimbursed__c, CreatedDate FROM Expense__c];
    }
    
	@AuraEnabled
    public static Expense__c saveExpenseRecord(Expense__c expenseapexVariable) {
        // Perform isUpdatable() checking first, then
        upsert expenseapexVariable;
        return expenseapexVariable;
    }    
}