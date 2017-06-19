public with sharing class selectoptions {

    
    public List<SelectOption> options{get;set;}
    public String Selection{get;set;}
    private list<Account> accounts;
    public transient list<Contact> contacts{get;set;}
    public Contact contact{get;set;}
    public Account acc{get;set;}
    public List<SelectOption> contactslist{get;set;}
    public Account selectedAccount{get;set;}
    
    public selectoptions(ApexPages.StandardController controller) {
        acc=new Account();
        contact=new Contact();
        contactslist=new List<SelectOption>();
        contactslist.add(new SelectOption('','--None--'));
        
        accounts=[select name from Account limit 10];
        
        options= new List<SelectOption>();    
        options.add(new SelectOption('','--None--'));
        for(Account a:accounts){
            options.add(new SelectOption(a.id,a.name));
        }
        selectedAccount =new Account();
       
    }

    
    public selectoptions() {
        acc=new Account();
        contact=new Contact();
        contactslist=new List<SelectOption>();
        contactslist.add(new SelectOption('','--None--'));
        
        accounts=[select name from Account limit 10];
        
        options= new List<SelectOption>();    
        options.add(new SelectOption('','--None--'));
        for(Account a:accounts){
            options.add(new SelectOption(a.id,a.name));
        }
        selectedAccount =new Account();
       
        
    }
    
    public PageReference selectedValue(){
        contactslist=Null;
        contactslist=new List<SelectOption>();
        contactslist.add(new SelectOption('','--None--'));
        contacts=[select id,name from contact where AccountId=:Selection];
        selectedAccount = [select id,name from Account where id=:Selection];
        if(!contacts.isEmpty())
        contactslist.remove(0);
        for(Contact c:contacts){
        contactslist.add(new SelectOption('one','one'));
        }
        return null;
    }
    
    public List<SelectOption> getAccountTypes(){
        
        Schema.DescribeFieldResult fr = Account.Type.getDescribe();
        List<Schema.PicklistEntry> atypes = fr.getPicklistValues();
        List<SelectOption> accounttypes=new List<SelectOption>();
        for(Schema.PicklistEntry p:atypes){
            accounttypes.add(new SelectOption(p.getLabel(),p.getValue()));
        }
        return accounttypes;
    }
 
    
}