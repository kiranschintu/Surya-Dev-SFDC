public class S2sCalledClass{
    
    public static void doshare(Map<String,String> sharedRecs){
        PartnerNetworkConnection ConId = [Select id from PartnerNetworkConnection where connectionStatus = 'Accepted' and connectionName ='My Developer Org' ];                                           
        
        List<PartnerNetworkRecordConnection> newConnections = new List<PartnerNetworkRecordConnection>();
        for(String s: sharedRecs.values()){
        PartnerNetworkRecordConnection newConnection = new PartnerNetworkRecordConnection();
        newConnection.ConnectionId = ConId.id;
        newConnection.LocalRecordId = s;
        //if(objAccountToShare.ParentRecordId!=null)
        //newConnection.ParentRecordId = objAccountToShare.ParentRecordId;
        newConnection.SendClosedTasks = false;
        newConnection.SendOpenTasks = false;
        newConnection.SendEmails = false;
        newConnections.add(newConnection);
        }

        insert newConnections;
    }
    
}