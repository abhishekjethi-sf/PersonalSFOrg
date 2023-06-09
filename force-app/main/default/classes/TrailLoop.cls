public class TrailLoop {
   
 
    
    //Here is a combined problem of a query that needs a filter
    //and a loop that continually calls out to the database
    public static void AllGoodThings(Account a) {
        List<Task> allMyTasks = [Select Id, status, whatId From Task WHERE WhatId =: a.Id];
        for (Task t : allMyTasks) {
            if (t.whatId == a.id) {
                t.status = 'Completed';
            }
        }
        update allMyTasks;
    }
}