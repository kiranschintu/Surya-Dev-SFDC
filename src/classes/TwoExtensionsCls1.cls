public with sharing class TwoExtensionsCls1 {
    public Account acc{get;set;}
    public Static Contact con{get;set;}
    public Static String fname{get;set;}
    
    public TwoExtensionsCls1(ApexPages.StandardController controller) {
        //acc = new Account();
        System.debug('Debug Ext1 Constructor >>>');
        System.debug('Debug Ext1 acc>>>'+acc);
    }
    public PageReference dosomeExt1(){
        TwoExtensionsCls2 ob = new TwoExtensionsCls2();
       acc = ob.doSome(acc);
       
       return null;
    }

}