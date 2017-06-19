trigger ContactTrigger1 on Contact (after insert,before insert) {
    
    system.debug('Check');
    if(trigger.isAfter){
    //S2SConnectionHelper.contactShare(trigger.new);
    }
    if(trigger.isBefore){
        Set<String> accoutIds = new Set<String>();
        Set<String> shardAccIds = new Set<String>(); 
        for(Contact con:trigger.new){
            system.debug('Contact >>>'+con);
            system.debug('Contact created by Id >>>'+con.CreatedById);
            system.debug('Current User Id >>>'+userInfo.getUserId());
            system.debug('Contact created by >>>'+con.CreatedBy);
            system.debug('Contact AccountId >>>'+con.AccountId);
            system.debug('Connection Received Id >>>'+con.ConnectionReceivedId);
            
            if(con.ConnectionReceivedId!=null && con.AccountId==null){
                con.addError('Account does not exist');
                system.debug('Error Occured');
            }else{
                system.debug('Error not Occured');
            }
            
            /*else{
                
                accoutIds.add(con.AccountId);
                system.debug('Connection Established');
                }*/
        }
        /*
        if(!accoutIds.isEmpty()){
            for(PartnerNetworkRecordConnection accountSharingRecord: [SELECT p.Status, p.LocalRecordId, p.ConnectionId FROM PartnerNetworkRecordConnection p WHERE p.LocalRecordId IN:accoutIds ]){
                system.debug('Checking Account Sharing');
                system.debug('accountSharingRecord.Status'+accountSharingRecord.Status);
                if(accountSharingRecord.Status!='Sent' && accountSharingRecord.Status!='Received'){
                    shardAccIds.add(accountSharingRecord.LocalRecordId);    
                }
            }
            
            for(Contact con:trigger.new){
                if(shardAccIds.contains(con.AccountId)){
                    con.addError('Account does not shared.');
                    system.debug('Account does not share. Error Occured');
                }
            }
        }
        */
    }
    
}