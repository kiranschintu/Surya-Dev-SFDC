trigger NoOfContactsOnAccount on Contact (after insert, after delete,after undelete,after update) {
    Set<Id> aId = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUndelete){
        for(Contact opp : Trigger.New){
            aId.add(opp.AccountId);
        }
        
    }
    
    if(Trigger.isDelete){
        for(Contact opp : Trigger.old){
            aId.add(opp.AccountId);
        }
    }
    
    if(Trigger.isUpdate){
       Set<Id> OldAId = new Set<Id>(); 
        for(Contact opp : Trigger.new){
        if(opp.AccountId != Trigger.oldMap.get(opp.id).AccountId || opp.dhr__Amount__c!= Trigger.oldMap.get(opp.id).dhr__Amount__c)
            aId.add(opp.AccountId);
            aId.add(Trigger.oldMap.get(opp.id).AccountId);
        }
    }
    
    if(!aid.isEmpty()){
        //for Contacts count
        //Map<Id,Account> acc = new Map<Id,Account>([select id,No_Of_Contacts__c,(select id from Contacts) from Account where Id in:aId]);
        
        /*for(Account a : acc.values()){
            a.No_Of_Contacts__c=a.contacts.size();
            system.debug('Hello>>>'+a.contacts.size());  
        }*/
        List<Account> acc = new List<Account>();
        for(AggregateResult agrs :[select Sum(dhr__Amount__c)amount,AccountId from Contact where AccountId!=null AND AccountId in:aId Group By AccountId]){
            system.debug('Result>>>'+agrs.get('AccountId'));
            Account ac = new Account();
            ac.id = String.valueOf(agrs.get('AccountId'));
            ac.dhr__Contacts_Amount__c = Double.valueOf(agrs.get('amount'));
            acc.add(ac);
        }
        update acc;
    }
}