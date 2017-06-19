public class ManageListController
{
 
 public List<AccountWrapper> wrappers {get; set;}
 public static Integer toDelIdent {get; set;}
 public static Integer addCount {get; set;}
 private Integer nextIdent=0;
 public Account acc;

  
 public ManageListController()
 {
  
  
  wrappers=new List<AccountWrapper>();
  for (Integer idx=0; idx<3; idx++)
  {
  acc = new Account(); 
   wrappers.add(new AccountWrapper(nextIdent++,acc));
  }
 
 }
  
 public void delWrapper()
 {
  Integer toDelPos=-1;
  for (Integer idx=0; idx<wrappers.size(); idx++)
  {
   if (wrappers[idx].ident==toDelIdent)
   {
    toDelPos=idx;
    nextIdent--;
   }
  }
   
  if (-1!=toDelPos)
  {
   wrappers.remove(toDelPos);
  }
 }
  
 public void addRows()
 {
  for (Integer idx=0; idx<addCount; idx++)
  {
   wrappers.add(new AccountWrapper(nextIdent++,acc));
  }
 }
  
 public PageReference save()
 {
  List<Account> accs=new List<Account>();
  acc = new Account();
  for (AccountWrapper wrap : wrappers)
  {
  
   accs.add(wrap.acc);
  }
   wrappers=null;
  
  try{
  insert accs;
  }catch(DMLException ex){}
   
  for(Account an:accs ){
       if(an.Active__c=='No'){
       return null;}
       }
        return (new pagereference('/apex/sucess'));
       
        
  
 }
  
 public class AccountWrapper
 {
  public Account acc {get; set;}
  public Integer ident {get;set;}
   
  public AccountWrapper(Integer inIdent,Account acc)
  {
   ident=inIdent;
  this.acc=acc;
  }
 }
}