trigger StreetAddress on Account (before insert,before update,after insert,after update) {
 System.debug('Making future call to update account');
  
  if(trigger.isBefore){
      if(trigger.isInsert){
      for(Account acc:Trigger.New){
          if(acc.billingcity!=Null && acc.billingStreet!=Null && acc.billingpostalcode!=Null){
              acc.Reload_Status__c=True;
              acc.Dont_Reload__c='s';
          }
          else
          acc.Dont_Reload__c='n';
      }
      }
      if(trigger.isupdate){
      for(Account acc:Trigger.New){
          if(updateHelper.inFutureContext==False){
          if(acc.billingstate!=trigger.oldmap.get(acc.id).billingstate || acc.billingcity!=trigger.oldmap.get(acc.id).billingcity || acc.billingStreet!=trigger.oldmap.get(acc.id).billingStreet || acc.billingpostalcode!=trigger.oldmap.get(acc.id).billingpostalcode || acc.BillingCountry!=trigger.oldmap.get(acc.id).billingCountry){
              acc.Reload_Status__c=True;
              acc.Dont_Reload__c='s';
          }
          else
              acc.Dont_Reload__c='n';
          }
      }
      }
  }
    
  if(trigger.isAfter){
    if(trigger.isInsert){
        for(Account acc : Trigger.New){
            if(acc.billingcity!=Null && acc.billingStreet!=Null && acc.billingpostalcode!=Null)
            StreetVerficationCon.updateAccount(acc.Id, acc.Name);
        }
    }
    if(trigger.isUpdate){
        for(Account acc : Trigger.New){
        if(updateHelper.inFutureContext==False){
            if(acc.billingstate!=trigger.oldmap.get(acc.id).billingstate || acc.billingcity!=trigger.oldmap.get(acc.id).billingcity || acc.billingStreet!=trigger.oldmap.get(acc.id).billingStreet || acc.billingpostalcode!=trigger.oldmap.get(acc.id).billingpostalcode || acc.BillingCountry!=trigger.oldmap.get(acc.id).billingCountry)
                StreetVerficationCon.updateAccount(acc.Id, acc.Name);
          }
        }
      }
  }
  
}