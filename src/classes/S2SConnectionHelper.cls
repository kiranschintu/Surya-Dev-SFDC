public class S2SConnectionHelper{
//Get the Connection Id based on Connection Name
public static Id getConnectionId(String connectionName) {        
   List<PartnerNetworkConnection> partnerNetConList =[Select id from PartnerNetworkConnection where connectionStatus = 'Accepted' and connectionName = :connectionName];
   if ( partnerNetConList.size() != 0 ) {
         return partnerNetConList.get(0).Id;
   }    
         return null;
} 

//Get the Connection Owner based on Connection Name 
public static Id getConnectionOwnerId(String connectionName) {
   List<PartnerNetworkConnection> partnerNetConList =[Select createdById from PartnerNetworkConnection where connectionStatus = 'Accepted' and connectionName = :connectionName];  
   if ( partnerNetConList.size() != 0 ) {
         return partnerNetConList.get(0).createdById;
   }     
         return null;
}

//Share Records
public static void recordShare(List<SObject> newList){ 
    // Define connection id
    Id networkId = getConnectionId('My Developer Org');
    system.debug('networkId &&&'+networkId);

    Set<Id> localRecordsSet = new Set<Id>();
    List<sObject> localRecords = new List<sObject>();
    Set<Id> sharedRecordsSet = new Set<Id>();

    // only share records created in this org.
    for(SObject sObj: newList){
        system.debug('SObject Type>>>'+newList.getSObjectType());
        system.debug('Default SObject Type>>>'+Contact.sObjectType);
        
        /*string objectTypeCS='Contact';
        sObject updateObj;
        String objectType = String.valueOf(newList.getSObjectType());
        Schema.sObjectType objectDef = Schema.getGlobalDescribe().get(objectType).getDescribe().getSObjectType();
        updateObj = objectDef.newSobject();
        system.debug('updateObj type >>>'+updateObj.getSObjectType());
        String objType = String.valueOf(objectDef);
        if(objType==objectType){
            system.debug('This is '+objType);
            updateObj.put('lastname','hello');
        }*/
        String objType = String.valueOf(newList.getSObjectType());
        S2SRecordSharing__c objTypeCSVals = S2SRecordSharing__c.getInstance(objType);
        String objTypeCS = objTypeCSVals.Name;
                
        
        sObject sObjct;
        if(objType == objTypeCS){
            localRecordsSet.add((Id)sObj.get(objTypeCSVals.Parent_Field_Name__c));
            localRecords.add(sObj);
        }       
    }
    
    system.debug('localRecordsSet &&&'+localRecordsSet);
    if (localRecordsSet.size() > 0) {
        // Get the  partner network record connections
        for (PartnerNetworkRecordConnection SharingRecord:[SELECT p.Status, p.LocalRecordId, p.ConnectionId FROM PartnerNetworkRecordConnection p WHERE p.LocalRecordId IN:localRecordsSet]) {
        // for each partner connection record  check if it is active
        if(!Test.isRunningTest()){
            if ((SharingRecord.status.equalsignorecase('Sent')|| SharingRecord.status.equalsignorecase('Received'))&& (SharingRecord.ConnectionId == networkId )) {
                sharedRecordsSet.add(SharingRecord.LocalRecordId);
                system.debug('Partner connection established');
            }
        }
        else{
                Account acc = new Account();
                acc.name = 'test';
                insert acc;
                sharedRecordsSet.add(acc.id);
        }
        }

    system.debug('sharedRecordsSet&&&'+sharedRecordsSet);

    if (sharedRecordsSet.size() > 0) {
    List<PartnerNetworkRecordConnection> recordConnections = new List<PartnerNetworkRecordConnection>();
    List<Attachment> attachs = new List<Attachment>();
    List<CaseComment> caseComm = new List<CaseComment>();
        system.debug('SObject Type>>>'+newList.getSObjectType());
        system.debug('Default SObject Type>>>'+Contact.sObjectType);
        for (SObject sObj: localRecords) {
            
            String objType = String.valueOf(newList.getSObjectType());
            S2SRecordSharing__c objTypeCSVals = S2SRecordSharing__c.getInstance(objType);
            String objTypeCS = objTypeCSVals.Name;
                    
            sObject sObjct;
            if(objType == objTypeCS){
                String pid = objTypeCSVals.Parent_Field_Name__c;
                if(sharedRecordsSet.contains((Id)sObj.get(pid))) {
                    PartnerNetworkRecordConnection newConnection = new PartnerNetworkRecordConnection(ConnectionId = networkId ,
                    LocalRecordId = (Id)sObj.get('id'),
                    SendClosedTasks = false,
                    SendOpenTasks = false,
                    SendEmails = false,
                    ParentRecordId = (Id)sObj.get(objTypeCSVals.Parent_Field_Name__c));
                  
                    system.debug('newConnection contact&&& '+newConnection);
                    recordConnections.add(newConnection);
                }  
            } 
        }

    system.debug('recordConnections&&&'+recordConnections);
    if (recordConnections.size() > 0 ) {
        database.insert(recordConnections);
    }
    if(!attachs.isEmpty()){
        database.update(attachs);
    }
    if(!caseComm.isEmpty()){
        database.update(caseComm);
    }
    }
    }
}
}