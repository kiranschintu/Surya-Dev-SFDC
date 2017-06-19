global with sharing class JavascriptRemotingCon{

    //public String RemoteAction { get; set; }
    
    @RemoteAction
    global static List<Account> findAll(){
        return [select id,name from Account limit 3];
    }
}