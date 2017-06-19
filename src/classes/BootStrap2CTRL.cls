public with sharing class BootStrap2CTRL{
    public List<Account> accounts{get;set;}
    
    public BootStrap2CTRL(){
        accounts = [Select id,name,phone,rating from Account];
    }
}