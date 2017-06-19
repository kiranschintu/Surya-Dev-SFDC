global with sharing class RemoteActionCalling {
public static string status{get;set;}
@RemoteAction
    global static String myRemoteCall(string tst){
        //status='java script';
        system.debug('---Remote Executed---'+tst);
        return 'result';
    }
}