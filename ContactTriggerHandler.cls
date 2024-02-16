public with sharing class ContactTriggerHandler {
    public static void afterUpdate(Map<ID, Contact> oldContactMap, Map<ID, Contact> newContactMap) {
        List<Contact> contacts = [SELECT LastName FROM Contact WHERE Id IN :newContactMap.keyset()];
        List<Account> accsToUpdate = new List<Account>(); 
        for(Id conId : newContactMap.keySet()) {
            Contact newCon = newContactMap.get(conId);
            Contact oldCon = oldContactMap.get(conId);
            if(newCon.LastName != oldCon.LastName) {
                Account updatedAcc = new Account(
                    Id = newCon.AccountId,
                    Name = newCon.LastName + ' Household'
                );
                accsToUpdate.add(updatedAcc);
            }
        }
        update accsToUpdate;    
    }
}