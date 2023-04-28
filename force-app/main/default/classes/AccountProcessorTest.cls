@isTest
private class AccountProcessorTest {

    @isTest static void updateContactsCount() {
       list<Account> accList = new list<Account>();
       for(Integer i = 1;i<=5;i++){
       	   Account acc = new Account(Name = 'Test Account '+i);
       	   accList.add(acc);
       }
       insert accList;
       
       list<Contact> conList = new list<Contact>();
       for(Integer i = 0; i<accList.size();i++){
       		Contact con = new Contact(LastName = 'Test User', Email = 'test@test.com', AccountId = accList[i].Id);
       		conList.add(con);
       }
       insert conList;
       
       list<Id> accIds = new list<Id>();
       for(Account acc : accList){
       		accIds.add(acc.Id);
       }
       system.assertEquals(5,accIds.size());
       
       Test.startTest();
       	   AccountProcessor.countContacts(accIds);
       Test.stopTest();
       
       list<Account> updatedAccList = [SELECT Number_of_Contacts__c FROM Account];
       system.assertEquals(1,updatedAccList[0].Number_of_Contacts__c);
       system.assertEquals(1,updatedAccList[4].Number_of_Contacts__c);
    }
}