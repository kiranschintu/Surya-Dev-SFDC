trigger ContactTriggerNameIdLogic on Contact (before Insert) {
    Set<Id> accIds = new Set<Id>();
    Map<Id,String> maxNumParents = new Map<Id,String>();
    Map<Id,Account> noChildParents = new Map<Id,Account>();
    Map<Id,Integer> currentRecsCount = new Map<Id,Integer>();
    
    for(Contact con:trigger.new){
        accIds.add(con.AccountId);
    }
    
    for(Account acc:[Select id,name from Account where id IN : accIds]){
        noChildParents.put(acc.id,acc);
    }
    
    for(contact con : [select id,lastName,Account.Name from COntact where AccountId IN:accIds order by lastname]){
        Integer maxNo = Integer.valueOf(con.lastname.split('-')[1]);
        system.debug('Max No:'+maxNo);
        //maxNums.put(con.accountId,maxNo);
        currentRecsCount.put(con.accountId,maxNo);
        maxNumParents.put(con.accountId,con.Account.Name);
    }
    
    for(Contact con:trigger.new){
        Integer count=1;
        if(maxNumParents.containsKey(con.AccountId)){
            count = currentRecsCount.get(con.accountId);
            count +=1 ;
            system.debug('Max No:'+count);
            con.Lastname = maxNumParents.get(con.accountId)+'-'+count;
            system.debug('Lastname'+con.Lastname);
            //currentRecsCount.put(con.accountId,count);
        }else{
            if(currentRecsCount.containsKey(con.accountId)){
                count = currentRecsCount.get(con.accountId);
                count +=1 ;
                con.Lastname = noChildParents.get(con.accountId).Name+'-'+count;
            }else{
                con.Lastname = noChildParents.get(con.accountId).Name+'-'+count;
            }
            
        }
        currentRecsCount.put(con.accountId,count);
    }
}