public with sharing class InlineEditPageaccountcon {

    public Account acc{get;set;}
    public InlineEditPageaccountcon(ApexPages.StandardController controller) {
        acc = (Account)controller.getRecord();
        acc = [select id,phone from Account where id =:acc.id];
    }
    public pagereference save(){
        update acc;
        return null;
    }

}