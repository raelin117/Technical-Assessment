@isTest
private with sharing class ContactTriggerHandlerTest {
   @TestSetup
   static void makeData(){

    Account acc = New Account(
        Name= 'Test Account'
    );

    insert acc; 

    Contact con = New Contact(
        FirstName = 'John',
        LastName = 'Doe',
        Email = 'johndoe@test.com',
        AccountId = acc.Id
    );

    insert con;
   }

   @IsTest
   private static void test_contact_name_update(){
       
        Contact con = [SELECT LastName, AccountId FROM Contact LIMIT 1];
        con.LastName = 'Smith';
        Test.startTest();
        update con; 
        Test.stopTest();

        Account acc = [SELECT Name FROM Account WHERE Id = :con.AccountId LIMIT 1];
        System.assertEquals('Smith Household', acc.Name);
   }

}