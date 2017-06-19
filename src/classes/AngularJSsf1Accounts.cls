public with sharing class AngularJSsf1Accounts{
    public Attachment attachmnt{get;set;}
    
    public AngularJSsf1Accounts(){
        attachmnt = new Attachment();
        attachmnt = [Select id from Attachment where id='00P9000000sysLl'];
    }
    @RemoteAction
    public static List<Account> fetchAccounts(){
        
        return [Select id,name,phone,rating,AnnualRevenue from Account where phone!=null AND rating!=null AND AnnualRevenue!=null limit 5000];
        
        /*List<ResponseWrapper> responseData = new List<ResponseWrapper>();
        for(Account acc:[Select id,name,phone,rating from Account limit 10]){
            ResponseWrapper respWrap = new ResponseWrapper();
            respWrap.acc = acc;
            
            responseData.add(respWrap);
        }
        return JSON.serializepretty(responseData);*/
    }
    
    @RemoteAction
    public Static void updateAccount(String accRec){
        Account acc = (Account)JSON.deserialize(accRec,Account.class);
        system.debug('Account:::'+acc);
        update acc;
    }
    
    public class ResponseWrapper{
        public Account acc;
    }
}