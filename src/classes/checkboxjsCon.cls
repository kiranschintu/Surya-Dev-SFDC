public with sharing class checkboxjsCon {
    public List<Account> accs{get;set;}
    public boolean check{get;set;}
    
    public checkboxjsCon(){
    check = true;
        accs = [select id,name,phone from Account limit 3];
    }
}