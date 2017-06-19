trigger ReloadOnceInlinePage on Account (before insert,before update,after insert,after update) {
    if(trigger.isAfter){
        /*for(Account acc:trigger.new){
            acc.dhr__Reload_Once_Inline__c=true;
        }*/
        ReloadFuture.dosome();
    }
    /*if(trigger.isAfter){
        if(RecursiveTrigerStop.status==true){
        RecursiveTrigerStop.status=false;
            for(Account a:trigger.new){
                Account ac = new Account();
                ac.id=a.id;
                ac.dhr__Reload_Once_Inline__c=false;
                update ac;
                
            }
        }
    }*/
}