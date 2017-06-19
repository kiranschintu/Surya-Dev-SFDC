public class mycon {
  /* public Account account;
    public mycon(){
    account =[select id,name,phone from account where id=:apexpages.currentpage().getparameters().get('id')];
    }
    public Account getAccounrecords(){
    return account;
    }*/
   /* public Account account{get;set;}
    public static Id Aid;
    public mycon(){
    Aid=apexpages.currentpage().getparameters().get('id');
    account =[select id,name,phone from account where id=:Aid];
    }
    public Account records(){
    
    return account;
    }*/
    
    /*public Account account;
   
    public Account getAccounrecords(){
    account =[select id,name,phone from account where id=:apexpages.currentpage().getparameters().get('id')];
    return account;
    }*/
    
    public List<Account> account{get;set;}
    
    public mycon(){
    account =[select id,name,phone from account limit 1000];
    //return account;
    }
    public List<Account> reocords(){
    return account;
    }
    
    
    
    
}