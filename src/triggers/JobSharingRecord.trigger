trigger JobSharingRecord on Job__c (after insert,after update) {
    //User u = [SELECT id from User where ];
    for(Job__c job:Trigger.new){
        JobSharing.manualShareRead(job.id,'00590000001fU4X');
    }
}