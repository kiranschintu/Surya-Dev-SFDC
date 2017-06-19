public class mypagecontroller {

//attributes|properties
public list <Account> myrecords {get;set;}

 
 
//constructor
public mypagecontroller(){
    myrecords =new list <Account> ();
    Account acc = new Account();
    for(Integer i=0;i<3;i++){
    
    myrecords.add(acc);
    }
}
public void addrow(){
        myrecords.add(new Account());
    }

//methods|functions


public PageReference saving ()
{ 
try{
insert myrecords ;
}catch (DMLException ex){}
for(Account an:myrecords){
if(an.Active__c=='No'){
return null;
}
}
return (new pagereference('/apex/sucess'));
}
public class AccountWrapper
 {
  public Account acc {get; private set;}
  public Integer ident {get; private set;}
   
  public AccountWrapper(Integer inIdent,Account acc)
  {
   ident=inIdent;
  this.acc=new Account();
  }
 }

}