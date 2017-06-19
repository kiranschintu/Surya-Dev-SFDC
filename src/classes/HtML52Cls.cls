public with sharing class HtML52Cls {
     public String AccountName{ get; set; }
     public integer hello{ get; set; }
     public Date fDate { get; set; }
     public string email{get;set;}
     public string phone{get;set;}
 
     List<String> lstAccounts;
 
     public List<String> getAccounts() {
     
          lstAccounts=new List<String>();
          for(Account acc:[Select Id ,Name from Account Limit 1000]){
             lstAccounts.add(acc.name);
          }
          
        return lstAccounts;
    }
    
    public void  setAccounts(List<String> s) {
        this.lstAccounts=s;
    }
 
 
  
}