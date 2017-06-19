public with sharing class AccountInlineCon {
    Public static Account acc{get;set;}
    public static integer count=0;
    Public static Account accc{get;set;}
    
    public Date d1{get;set;}
    public Date d2{get;set;}
    public Time t1{get;set;}
    public Time t2{get;set;}
    public Time t3{get;set;}
    public string status{get;set;}
    
    public AccountInlineCon(ApexPages.StandardController controller) {
    //count=0;
    acc = (Account)controller.getRecord();
    
    }
    
    public PageReference incrementCounter() 
  {
       accc = [Select id,name,phone,Last_Modified_Date_For_Reload__c,lastmodifieddate from Account where id='0019000000nvko3'];
       d1=accc.Last_Modified_Date_For_Reload__c.Date();
       d2=system.now().Date();
       t1=accc.Last_Modified_Date_For_Reload__c.Time();
       t2=system.now().Time();
       t3=t2-(1000*20);
       if(t1 == t3)
       status='Equal';
       if(t1 >= t2)
       status='Greater than Equal';
       if(t1 <= t2)
       status='Less than Equal';
    count++;
    return null;
  }
  public integer getCount(){
  return count;
  }

    /*
    
    @future
    public static void dosomemore(){
    acc = [Select id,name,phone from Account where id=:acc.id];
    Integer i=1;
    acc.phone=''+i;
    update acc;
    i++;
    //doSome();
    
    }
    
    public static PageReference doSome(){
    acc = [Select id,name,phone from Account where id=:acc.id];
    //acc.phone='1234';
    //update acc;
     PageReference pg = new PageReference('/'+acc.Id);
     pg.setRedirect(true);
     return pg;
    
    
    }
    */
    

}