public class CheckFutureCon{
    @Future
    public static void docheck(List<Id> UpdatedIds){
         System.debug('checking Class Out Forloop$$$');
        for(Id uid : UpdatedIds){
         System.debug('Cechcking Class$$$');
            CheckFutureMainCon ob = new CheckFutureMainCon();
            ob.docheck();
        }
    }
}