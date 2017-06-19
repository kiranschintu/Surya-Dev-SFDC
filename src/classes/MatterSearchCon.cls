/*
/////////////////////////////////////////////////
CREATED BY: Vijaya
CREATED ON: 
PURPOSE: Controller class to searh Matters and create new Requests
/////////////////////////////////////////////////
*/
public with sharing class MatterSearchCon {
    public Matter__c matter{get;set;}
    public List<Work_Product__c> requests{get;set;}
    public Work_Product__c newRequest{get;set;}
    public Work_Product__c updRequest{get;set;}
    public boolean newreasta{get;set;}
    public boolean editReq{get;set;}
    public Integer reqCount{get;set;}
    public String editId{get;set;}
    
    public MatterSearchCon(){
        matter = new Matter__c();
        newRequest = new Work_Product__c();
        reqCount=0;
    }
    
    //Retrieve requests based on ConcourseMatterId
    public void retrieveRequests(){
        Matter__c mat = new Matter__c();
        requests = new List<Work_Product__c>();
        Boolean isExist;
        try{
            //Retrieve matters
            mat = [select id,name from Matter__c where ConcourseMatterId__c=:matter.ConcourseMatterId__c];
            system.debug('Matter%%%'+mat);
            if(mat!=null){
                isExist=true;
            }
        }catch(Exception e){
            system.debug('Error Occured'+e.getMessage());
            isExist=false;
        }
        
        if(isExist==true){
            //Retrieve Requests by passing matter ids
            requests  = [select id,name,Related_Matter__c,CreatedDate,Work_Product_Name__c from Work_Product__c where Related_Matter__c=:mat.id order by CreatedDate desc];
            reqCount = requests .size();
            system.debug('Requests%%%'+requests);
        }
        
        if(requests.isEmpty()){
            //Display page message if no request found
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.error,'No Requests found');
            ApexPages.addMessage(msg);
        }
    }
    //Enable new Request creation block while creating new request
    public void newRequest(){
        newreasta=true;            
    }
    //Editing Request
    public void editRequest(){
        editReq=true;
        newreasta=false;
        updRequest = [select id,name,Related_Matter__c,CreatedDate,Work_Product_Name__c from Work_Product__c where id=:editId]; 
        reqCount =0;
    }
    //Inserting new Request
    public pagereference save(){
        try{
            insert newRequest;
            //Return request to standard page after new Request insert
            PageReference pg = new ApexPages.StandardController(newRequest).view();
            return pg;
         }catch(Exception e){
            //Display page message on page if any error occurs
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.error,'Error Occured'+e.getMessage());
            ApexPages.addMessage(msg);
            return null;
         }
    }
    //Updating existing Request
    public void updateReq(){
        try{
            update updRequest;
             retrieveRequests();
             reqCount = requests .size();
            editReq=false;
        newreasta=false;

         }catch(Exception e){
            //Display page message on page if any error occures
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.error,'Error Occured'+e.getMessage());
            ApexPages.addMessage(msg);
         }
    }
}