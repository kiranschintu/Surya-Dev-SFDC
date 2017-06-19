trigger SendSMSSummit on Account (after insert,after update) {

  System.debug('Making future call to update account');
  
  for (Account acc : Trigger.New) {
    SendSMSHttpContactSummitForTrigger.SendSMS(acc.Id);
    
  }
  
  if(trigger.IsInsert){
  
  }

}