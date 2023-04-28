/*
	This class will update the Latest SAP Creation Date of Contact on Account record
*/
public with sharing class UpdateSAPContactDateonAccountCls {

    public static void updateAccountRecord(list < Contact > contactList, map < Id, Contact > oldContactMap, String dmlOperation) {
        // Process the records
        set < Id > accountIdSet = new set < Id > ();
        for (Contact contactRecord: contactList) {
            // Inserting the contact records
            if (dmlOperation == 'INSERT' && !String.isBlank(contactRecord.accountId) && contactRecord.Status_Check__c == 'Confirmed') {
                accountIdSet.add(contactRecord.accountId);
            }
            // Updating the contact records
            else if (dmlOperation == 'UPDATE' && !String.isBlank(contactRecord.accountId) && contactRecord.Status_Check__c != oldContactMap.get(contactRecord.Id).Status_Check__c) {
                accountIdSet.add(contactRecord.accountId);
            }
            // Deleting the contact records
            else if (dmlOperation == 'DELETE' && !String.isBlank(contactRecord.accountId) && contactRecord.Status_Check__c == 'Confirmed') {
                accountIdSet.add(contactRecord.accountId);
            }
        }

        // Update the Accounts
        if (!accountIdSet.isEmpty()) {
            // Update the Account records
            list < Account > accountList = [SELECT Latest_SAP_Contact_Creation_Date__c, (SELECT SAP_Creation_Date__c FROM Contacts WHERE Status_Check__c = 'Confirmed'
                                            ORDER BY CreatedDate DESC LIMIT 1) FROM Account WHERE Id IN: accountIdSet];

            list < Account > updatedAccountList = new list < Account >(); // Updating the new Account list                                   
            // Process each record
            for (Account accountRecord: accountList) {
                // If no contact is found
                if (accountRecord.Contacts.size() == 0 && accountRecord.Latest_SAP_Contact_Creation_Date__c <> null) {
                    accountRecord.Latest_SAP_Contact_Creation_Date__c = null;
                    updatedAccountList.add(accountRecord);
                // If contact is found    
                } else if(accountRecord.Contacts.size() == 1 && accountRecord.Latest_SAP_Contact_Creation_Date__c <> accountRecord.Contacts[0].SAP_Creation_Date__c){
                    accountRecord.Latest_SAP_Contact_Creation_Date__c = accountRecord.Contacts[0].SAP_Creation_Date__c;
                    updatedAccountList.add(accountRecord);
                }
            }

            if(!updatedAccountList.isEmpty()){
                update updatedAccountList;
            }
        }
    }
}