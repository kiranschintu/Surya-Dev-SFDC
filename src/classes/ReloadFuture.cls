public class ReloadFuture{
    @future
    public static void dosome(){
        system.debug('Future Method called');
        ReloadOnce__c reld = ReloadOnce__c.getOrgDefaults();
        reld.dhr__ISReload__c=false;
        upsert reld;
        system.debug('after save:'+reld.dhr__ISReload__c);
    }
}