trigger descriptionUpdater on Account (after insert,after update) {

  System.debug('Making future call to update account'+trigger.newMap);
  
  //SendVFAsAttachment.sendVF(string.valueOf(userinfo.getSessionId()));
  
  FutureContext.dofutureCallout(trigger.oldMap.keySet());
  /*for (Account acc : Trigger.New) {
    //Call future method to update account
    //with data from external server.
    //This is a async calls, it returns right away, after
    //enqueuing the request.
    if(trigger.isInsert || trigger.isUpdate){
    if(!AccountUpdater.stoprecursion){
    AccountUpdater.updateAccount(acc.Id, acc.Name);
    }
    
    }
    
  }*/

}