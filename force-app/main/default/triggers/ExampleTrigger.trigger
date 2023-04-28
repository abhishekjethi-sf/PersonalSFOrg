trigger ExampleTrigger on Contact (after insert, after delete) {
    if (Trigger.isInsert) {
        Integer recordCount = trigger.new.size();
        // Call a utility method from another class
        //EmailManager.sendMail('abhishekjethi87@gmail.com', 'Trailhead Trigger Tutorial', recordCount + ' contact(s) were inserted.');
    }
    else if (Trigger.isDelete) {
        // Process after delete
    }
}