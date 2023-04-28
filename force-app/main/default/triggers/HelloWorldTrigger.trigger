trigger HelloWorldTrigger on Account (before insert) {
    for(Account acc : trigger.new){
        acc.Description = 'New description';
        system.debug('Size of the trigger records '+trigger.new.size());
    }
}