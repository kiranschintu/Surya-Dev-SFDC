public with sharing class TwoExtensionsCls2 {
    public string name1{get;set;}
    public TwoExtensionsCls2(ApexPages.StandardController controller) {
        System.debug('Debug Ext2 Constructor >>>');
    }
    
    public TwoExtensionsCls2(){
    
    }
    
    public void dosearch(){
        name1 = 'Hello Extension 2';
        system.debug('Hello doSearch');
    }
    
    public Account dosome(Account acc){
        
        System.debug('Debug Ext1 >>>'+acc);
        System.debug('Debug Ext1 >>>'+TwoExtensionsCls1.con);
        System.debug('Debug Ext1 >>>'+TwoExtensionsCls1.fname);
        return acc;
        
        //TwoExtensionsCls1.acc.Name= 'Account Name Changed>>>>';
    }

}