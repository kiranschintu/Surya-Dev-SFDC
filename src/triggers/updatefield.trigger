trigger updatefield on Contact (before insert) {
    
    for (Contact newOpp : Trigger.new) {
        //if(newOpp.phone=='11111')
        //newOpp.phone.addError('Error for phone');
        newOpp.reload__c='s';
    }
    
}