trigger UndeleteOnA on A__c (before update) {
    for(A__c aob:trigger.new){
        aob.dhr__Time_Zone__c='Record Updated frm Trigger. Count of Bs '+aob.dhr__Count_of_B__c;
    }
}