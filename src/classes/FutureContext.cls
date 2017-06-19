public class FutureContext{
    @future
    public static void dofutureCallout(set<Id> oldIds){
        system.debug('Old Ids');
        List<Account> accs = [select id,name,rating from Account where Id IN: oldIds];
        Account ac = accs[0];
        system.debug('Accs$$$'+system.trigger.oldMap);
    }
}