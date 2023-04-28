public class AccountList {

    @InvocableMethod(label='Get Account Information')
    public static List<FlowOutput> getAccountList(){
        List<FlowOutput> flowOutput = new List<FlowOutput>();
        FlowOutput output = new FlowOutput();
        list<Account> accountList = [SELECT Name,Rating,AccountNumber FROM Account WHERE Rating != null ORDER BY Rating ASC LIMIT 10];
        output.accountData = accountList;
        flowOutput.add(output);
        return flowOutput;
    }
    
    public class FlowOutput{
        @InvocableVariable()
        public List<Account> accountData;
    }
}