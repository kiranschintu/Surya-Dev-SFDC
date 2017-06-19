trigger UniqueAccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete,after undelete) {
    //calling utility class
    if(UniqueAccountTriggerUtility.isRecursive==false){
        UniqueAccountTriggerUtility.callStratagies(trigger.new,trigger.old,trigger.newMap,trigger.oldMap,trigger.isInsert,trigger.isUpdate,trigger.isDelete,trigger.isUndelete,trigger.isBefore,trigger.isAfter);
    }
}