public with sharing class reloadparentCls {
    public Account acc{get;set;}
    public reloadparentCls(ApexPages.StandardController controller) {
        acc = (Account)controller.getRecord();
        acc = [select id,phone from Account where id =: acc.id];
    }
    
    public void dosome(){
        update acc;
    }

}