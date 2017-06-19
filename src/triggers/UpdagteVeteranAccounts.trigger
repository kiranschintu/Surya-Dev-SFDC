trigger UpdagteVeteranAccounts on Contact (after update,after insert,after delete) {
    UpdateAccountAsVeteran.makeAccVeteran(trigger.new,trigger.old,trigger.isInsert,trigger.isUpdate,trigger.isDelete);
}