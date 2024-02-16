trigger ContactTrigger on Contact (after update) {
    ContactTriggerHandler.afterUpdate(Trigger.oldMap, Trigger.newMap);
}