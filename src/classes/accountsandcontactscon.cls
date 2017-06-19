public with sharing class accountsandcontactscon {

    public List<Account> accounts{get;set;}
    public List<Contact> contacts{get;set;}
    public String accn{get;set;}
    public String accid{get;set;}
    public Integer buttonstate{get;set;}
    public String symbol{get;set;}
    
    public accountsandcontactscon(ApexPages.StandardSetController controller) {
        accounts = (List<Account>)controller.getRecords();
        //accn = new Account();
        buttonstate=Null;
        symbol='+';
    }
    public PageReference dosome(){
        contacts = new List<Contact>();
       //String urlid = system.currentpage;getParameters().get('accountid');
        if(symbol=='+')
        symbol='-';
        else symbol='+';
        //else if(buttonstate==1)
        //buttonstate =2;
        contacts =[select id,name,accountid from contact where AccountId =:accid];
        return null;
    }

}