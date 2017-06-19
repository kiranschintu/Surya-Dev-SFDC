public with sharing class DisplayAllAccountsController {

    public List<Account> accounts{get;set;}
    final List<Account> acc;
    private string name;
    transient string owndescription='This is new Description regarding Transient';
    //define constructor
    public DisplayAllAccountsController (){
        accounts=[select id,Name,lastModifiedDate from Account limit 10];
        
        //acc = new List<Account>();
        acc = [select id,name from Account];
    }
}