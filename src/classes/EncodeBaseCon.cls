public with sharing class EncodeBaseCon {
    public Account account{get;set;}
    public String base64code{get;set;}
    public string base64codeblob{get;set;}
    public EncodeBaseCon(){
        account = [select id,name,image1__c,image__c,Image64__c from Account where id =:ApexPages.CurrentPage().getParameters().get('Id')];
        base64codeblob=EncodingUtil.base64Encode(blob.valueof(account.image1__c));
        //base64code=EncodingUtil.base64Encode(bae64codeblob);
    }
}