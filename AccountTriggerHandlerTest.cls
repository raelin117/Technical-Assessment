@isTest
private with sharing class AccountTriggerHandlerTest {
   @TestSetup
   static void makeData(){

    Account acc = New Account(
        Name= 'Test Account'
    );

    insert acc; 

    makeContacts(acc);

   }

   @IsTest
   private static void test_phone_update(){
        Account acc = [SELECT Id, Phone FROM Account LIMIT 1];
        acc.Phone = '212-555-0000';
        Test.startTest();
        update acc; 
        Test.stopTest();

        List<Contact> updatesCons = [SELECT Phone FROM Contact WHERE Phone = '212-555-0000' AND AccountId = :acc.Id];
        System.assert(updatesCons.size() == 300, 'List of contacts should match contacts related to account updated');
   }

   public static void makeContacts(Account acc) {
        Integer numRecords = 300;
        Integer i = 0; 
        List<Contact> cons = new List<Contact>(); 

        Set<String> firstNames = new Set<String> {'Mike', 'Toby', 'Pamela', 'Meredith', 'David', 'Kelly', 'Angela', 'Oscar'};
        Set<String> lastNames = new Set<String> {'Jones', 'Smith', 'Brown', 'Singh', 'Scott', 'Keenan', 'Michaels', 'Carroll', 'Chu'};

        while(i < numRecords) {
            
            String firstName = randomString(firstNames);
            String lastName = randomString(lastNames);
            Contact con = new Contact(
                FirstName = firstName,
                LastName = lastName,
                AccountId = acc.Id,
                Email = firstName + '.' + lastName + String.valueOf(i) + '@test.com'
            );
            cons.add(con); 
            i++; 
        }

        insert cons;
   }

   public static string randomString(Set<String> setArray) {
         
        List<String> lstArray = new List<String>(); 
        lstArray.addAll(setArray); 
        Double randomNumber = Math.random(); 
        Integer arrayLength = lstArray.size(); 
        Integer randomIndex = (randomNumber *(arrayLength-1)).intValue(); 

        return lstArray[randomIndex];
    }

}