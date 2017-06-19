trigger deleteprevent on Line_Item__c (before delete) {
    for(Line_Item__c l:Trigger.old){
        l.addError('You can not delete line item');
    }
}