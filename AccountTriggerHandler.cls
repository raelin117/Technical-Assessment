public with sharing class AccountTriggerHandler {
    public static void afterUpdate(Map<ID, Account> oldAccountMap, Map<ID, Account> newAccountMap) {
        List<Contact> contacts = [SELECT Phone FROM Contact WHERE AccountId IN :newAccountMap.keyset()];
        List<Contact> consToUpdate = new List<Contact>(); 
        for (ID accId : newAccountMap.keyset()) {
            Account newAcc = newAccountMap.get(accId);
            Account oldAcc = oldAccountMap.get(accId);
            if(newAcc.Phone != oldAcc.Phone) {
                for(Contact con : contacts) {
                    con.Phone = newAcc.Phone; 
                    consToUpdate.add(con);
                }
            }
        }
        update consToUpdate; 
    }
}