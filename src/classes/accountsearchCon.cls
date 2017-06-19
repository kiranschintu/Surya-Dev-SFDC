public with sharing class accountsearchCon {
    public List<Account> acc{get;set;}
    public String searchtopic{get;set;}
    public accountsearchCon(ApexPages.StandardController controller) {
        acc = new List<Account>();
        searchtopic = ApexPages.CurrentPage().getParameters().get('topic');
        if(searchtopic=='topic'){
        acc = [select id,name from Account limit 10];
        } 
    }
    public void retrieverecs(){
        acc = [select id,name,Account_Number__c from Account limit 100];    
    }
     public PageReference exporttoexcel(){
        PageReference pg = new PageReference('/apex/accountsearchexport?topic=topic');
        return pg;
    }

}