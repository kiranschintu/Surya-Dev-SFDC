public with sharing class pagemessagesCon {
    public Account acc{get;set;}
    public Boolean errorMessages{get;set;}
    public pagemessagesCon(){
        acc = [select id,name,Industry from Account where id=:ApexPages.CurrentPage().getParameters().get('id')];
        dosome();
    }
    public void dosome(){
        if(acc.Industry==Null || acc.Industry==''){
            errorMessages=true;
            ApexPages.Message msg1 = new ApexPages.Message(ApexPages.Severity.ERROR, 'Industry is Mandatory');
            ApexPages.addMessage(msg1);
        }
        
    }
}