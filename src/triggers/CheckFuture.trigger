trigger CheckFuture on Account (after Update) {
    List<Id> accids = new List<Id>();
    for(Account a :trigger.new){
        accids.add(a.id);
    }
    System.debug('Cechcking Trigger$$$');
    CheckFutureCon.docheck(accids);
}