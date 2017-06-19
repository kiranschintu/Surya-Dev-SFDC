trigger alertonce on Lead (before insert,after insert) {
    if(Trigger.isBefore){
    
    for(Lead l:Trigger.new){
        l.dhr__alert_once__c=False;
    }
    }
    if(Trigger.isAfter){
     for(Lead l:Trigger.new){
         aletoncecon.dofieldupdate(l.id);
     }   
    }
}