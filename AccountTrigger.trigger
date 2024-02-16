trigger AccountTrigger on Account (after update) {
    for (Account acc : Trigger.new) {
        AccountTriggerHandler.afterUpdate(Trigger.oldMap, Trigger.newMap);
    }
}