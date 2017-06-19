trigger CreatingRecordIn2Orgs on Account (after insert,after update) {

  System.debug('Making future call to update account');
  
  for (Account acc : Trigger.New) {
   // AuthCallout1.InsertAccountRecord();
    
  }
  }