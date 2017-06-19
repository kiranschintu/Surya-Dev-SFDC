@isTest(seeAllData=true)
private class IDme_verificationPluginTest{
    private static testmethod void unitTest1(){
        
        //List<AuthProvider> prov = [select consumersecret,consumerkey,FriendlyName from AuthProvider where friendlyname='ID.me'];
        
        IDme_verificationPlugin idmv = new IDme_verificationPlugin();
        idmv.describe();
        
        Map<String,Object> inputParams = new Map<String,Object>();
        String fName = 'First Name';
        String lname = 'Last Name';
        String ssn = 'SSN';
        String bDate = 'Birth Date';
        String sDate = 'Service Date';
        String authProviderName = 'test';//prov[0].friendlyname;
               
        InputParams.put('fName', 'f Name');
        InputParams.put('lname', 'l name');
        InputParams.put('ssn', '9999999999');
        InputParams.put('bDate', 'bDate');
        InputParams.put('sDate', 'sDate');
        InputParams.put('authProviderName', 'authProviderName');
        
        
        Process.PluginRequest plugreq = new Process.PluginRequest(inputParams);
        IDme_verificationPlugin.invoke(plugreq);
    }
}