public with sharing class ScrollBarsCls {
    public List<Account> accs{get;set;}
    public ScrollBarsCls(){
        accs = [select id,name,phone from Account limit 100];
    }
}