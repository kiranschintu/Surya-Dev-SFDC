public with sharing class AddBulkRowsOPPProduct {

 public List<AccountWrapper> wrappers {get; set;}
 public static Integer toDelIdent {get; set;}
 public static Integer addCount {get; set;}
 private Integer nextIdent=0;
 public OpportunityLineItem acc;

  
 public AddBulkRowsOPPProduct ()
 {
  
   acc = new OpportunityLineItem ();
  wrappers=new List<AccountWrapper>();
  for (Integer idx=0; idx<3; idx++)
  {
  
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
 acc = new OpportunityLineItem ();
  for (Integer idx=0; idx<addCount; idx++)
  {
   wrappers.add(new AccountWrapper(nextIdent++,acc));
  }
 }
  
 public PageReference save()
 {
  List<OpportunityLineItem > accs=new List<OpportunityLineItem>();
  acc = new OpportunityLineItem();
  for (AccountWrapper wrap : wrappers)
  {
  
   accs.add(wrap.acc);
  }
  
  try{
  insert accs;
  }catch(DMLException ex){}
   
  for(OpportunityLineItem an:accs ){
       //if(an.Active__c=='No'){
       return null;}
       //}
        return (new pagereference('/apex/sucess'));
       
        
  
 }
  
 public class AccountWrapper
 {
  public OpportunityLineItem acc {get; private set;}
  public Integer ident {get; private set;}
   
  public AccountWrapper(Integer inIdent,OpportunityLineItem acc)
  {
   ident=inIdent;
  this.acc=acc;
  }
 }

}