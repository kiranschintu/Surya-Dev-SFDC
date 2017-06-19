public class Tran3 {
    public List<Account> acc{get;set;}
    
    Public Tran3(){
        acc=[select id,name from Account];
    }
    
    public List<Account> records(){
        
        return acc;
    }
}