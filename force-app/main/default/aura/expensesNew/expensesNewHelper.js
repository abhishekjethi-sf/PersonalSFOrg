({   
    saveExpense: function(component, expense, callback) {
        var action = component.get("c.saveExpenseRecord");
        action.setParams({
            "expenseapexVariable": expense
        });
        if (callback) {
            action.setCallback(this, callback);
        }
        $A.enqueueAction(action);
    },
  
    createExpense: function(component, expense) {
        this.saveExpense(component, expense, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var expenses = component.get("v.expenseNewExpenses");
                expenses.push(response.getReturnValue());
                component.set("v.expenseNewExpenses", expenses);
            }
        });
    },
    
    updateExpense: function(component, expense) {
        this.saveExpense(component, expense);
    }
  
})