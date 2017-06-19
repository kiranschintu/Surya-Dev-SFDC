public class ReloadOnceNewCls {
    Account ac;
    public boolean customHstatus{get;set;}
    public ReloadOnceNewCls(ApexPages.StandardController controller) {
         ac = (Account)controller.getRecord();
    }
    
    public pageReference dosome(){
        ReloadOnce__c reld = ReloadOnce__c.getOrgDefaults();
        customHstatus = reld.dhr__ISReload__c;
        //reld.id = reld.id;
        reld.dhr__ISReload__c=true;
        upsert reld;
        update ac;
        return null;
    }    
}