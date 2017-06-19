trigger ContactTrigger on Contact (after insert,after update) {
    System.debug('Hell'+BriteVerifyContactHandler.isRecursive);
    if(BriteVerifyContactHandler.isRecursive){
        BriteVerifyContactHandler.prepareCalloutBatches(trigger.new,trigger.oldMap,trigger.isInsert,trigger.isUpdate);
    }
}