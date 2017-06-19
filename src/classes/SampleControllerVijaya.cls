public with sharing class SampleControllerVijaya 
{
    public String requestId{get;set;}
    public Work_Product__c wpObject {get; set;}
    
    public SampleControllerVijaya(){
            wpObject = [select id,name from Work_Product__c where id=:ApexPages.currentPage().getParameters().get('id')];
            requestId = wpObject.id;
    }
}