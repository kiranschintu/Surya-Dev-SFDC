trigger CustomOpportunityTrigger on Custom_Opportunity__c (after insert,after update) {
    List<Custom_Opportunity__Share> oppRecsToShare  = new List<Custom_Opportunity__Share>();
    List<Commission__share> comRecsToShare  = new List<Commission__share>();
    List<sObject> shareObjsToDel = new List<sObject>();//Hold Opportunity and Commision share records to delete
    
    if(trigger.isInsert){
        //Prepare Opportunity records to share
        for(Custom_Opportunity__c cusOpp : trigger.new){
            if(cusOpp.Agent__c!=null){
                Custom_Opportunity__Share oppShareRec  = new Custom_Opportunity__Share();      
                // Set the ID of record being shared.
                oppShareRec.ParentId = cusOpp.id;           
                // Set the ID of user or group being granted access.
                oppShareRec.UserOrGroupId = cusOpp.Agent__c;            
                // Set the access level.
                oppShareRec.AccessLevel = 'Edit';
                
                oppRecsToShare.add(oppShareRec);
            }
        }
    }
    if(trigger.isUpdate){
        Set<Id> oldOppShareRecOwners = new Set<Id>();//old users list to remove
        Set<Id> oppShareParIds = new Set<Id>();
        Set<Id> comsnShareParIds = new Set<Id>();
        //Prepare Opportunity records to share
        for(Custom_Opportunity__c cusOpp : trigger.new){
            if(cusOpp.Agent__c!=null && cusOpp.Agent__c!=trigger.oldMap.get(cusOpp.id).Agent__c){
                oldOppShareRecOwners.add(trigger.oldMap.get(cusOpp.id).Agent__c);
                oppShareParIds.add(cusOpp.id);            
                
                Custom_Opportunity__Share oppShareRec  = new Custom_Opportunity__Share();          
                // Set the ID of record being shared.
                oppShareRec.ParentId = cusOpp.id;               
                // Set the ID of user or group being granted access.
                oppShareRec.UserOrGroupId = cusOpp.Agent__c;                
                // Set the access level.
                oppShareRec.AccessLevel = 'Edit';
                
                oppRecsToShare.add(oppShareRec);
            }
        }
        //Prepare Commissions records to share
        for(Commission__c comsn:[Select id,Opportunity__r.Agent__c from Commission__c where Opportunity__c IN:oppShareParIds]){
            comsnShareParIds.add(comsn.id);
            
            Commission__share comShareRec  = new Commission__share();          
            // Set the ID of record being shared.
            comShareRec.ParentId = comsn.id;                
            // Set the ID of user or group being granted access.
            comShareRec.UserOrGroupId = comsn.Opportunity__r.Agent__c;              
            // Set the access level.
            comShareRec.AccessLevel = 'Edit';
                            
            comRecsToShare.add(comShareRec);
        }
        if(!oldOppShareRecOwners.isEmpty()){
            List<Custom_Opportunity__Share> cusOppSharToDel = [select id from Custom_Opportunity__Share where ParentId IN:oppShareParIds AND UserOrGroupId IN:oldOppShareRecOwners];
            
            List<Commission__Share> oldCommSharRecsToDel = [select id from Commission__Share where ParentId IN:comsnShareParIds AND UserOrGroupId IN:oldOppShareRecOwners];
            
            if(!cusOppSharToDel.isEmpty()){
                shareObjsToDel.addAll((List<sObject>)cusOppSharToDel);
                //delete cusOppSharToDel;
            }
            if(!oldCommSharRecsToDel.isEmpty()){
                shareObjsToDel.addAll((List<sObject>)oldCommSharRecsToDel);
                //delete oldCommSharRecsToDel;
            }
        }
        //delete both Opportunities and Commisions
        if(!shareObjsToDel.isEmpty()){
            delete shareObjsToDel;
        }
    }
    
    //Insert Opportunity records in share object
    if(!oppRecsToShare.isEmpty()){
        Database.insert(oppRecsToShare,false);
    }
    //Insert Commision records in share object
    if(!comRecsToShare.isEmpty()){
        Database.insert(comRecsToShare,false);
    }
}