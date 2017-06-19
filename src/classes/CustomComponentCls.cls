public class CustomComponentCls{
    public Account myAccCN{get;set;}
    
    public pageReference doSome(){
        try{
            system.debug('Record:::'+myAccCN);
            insert myAccCN;
        }catch(Exception e){
            system.debug('Code Error:::'+e);
        }
        return null;
    }
}