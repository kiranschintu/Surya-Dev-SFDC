public with sharing class PageBlockTableCls {
    public List<Account> accs{get;set;}
    public PageBlockTableCls(){
        accs = [select id,name from Account limit 3];
    }
}