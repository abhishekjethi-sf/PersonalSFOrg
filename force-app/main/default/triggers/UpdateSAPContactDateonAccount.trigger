/*
	This trigger will update the Latest SAP Creation Date of Contact on Account record
*/
trigger UpdateSAPContactDateonAccount on Contact(after insert, after update, after delete) {

    //INSERT
    if (trigger.isAfter && trigger.isInsert) {
        UpdateSAPContactDateonAccountCls.updateAccountRecord(trigger.new, null, 'INSERT');
    }
    //UPDATE
    else if (trigger.isAfter && trigger.isUpdate) {
        UpdateSAPContactDateonAccountCls.updateAccountRecord(trigger.new, trigger.oldMap, 'UPDATE');
    }
    // DELETE
    else if (trigger.isAfter && trigger.isDelete) {
        UpdateSAPContactDateonAccountCls.updateAccountRecord(trigger.old, null, 'DELETE');
    }
}