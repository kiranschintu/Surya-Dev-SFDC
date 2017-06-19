trigger deletepreventmer  on Merchandise__c (before delete) {

    for(Merchandise__c l:Trigger.new){
        l.addError('You can not delete Merchandise ');
    }

}