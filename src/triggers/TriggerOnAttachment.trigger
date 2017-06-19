trigger TriggerOnAttachment on Attachment (after insert) {
    for(Attachment atm : trigger.new){
        system.debug('Attachment >>'+atm);
        system.debug('Parent Type >>'+atm.ParentId);
        system.debug('Parent Type >>'+atm.Parent.Type);
    }
}