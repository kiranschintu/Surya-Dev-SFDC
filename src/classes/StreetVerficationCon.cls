public with sharing class StreetVerficationCon {
    
    public static Account accc{get;set;}
    public static Account acc{get;set;}
    public Integer count=0;
    public Date d1{get;set;}
    public Date d2{get;set;}
    public Time t1{get;set;}
    public Time t2{get;set;}
    public Time t3{get;set;}
    public Boolean LoadImgStatus{get;set;}
    
    
    public StreetVerficationCon(ApexPages.StandardController controller){      
        acc=(Account)controller.getRecord();
    }
    
    public PageReference incrementCounter(){
        String id = ApexPages.CurrentPage().getParameters().get('id');
        accc = [Select id,name,Street_Result__c,Last_Modified_Date_For_Reload__c,lastmodifieddate from Account where id=:id];
        d1=accc.Last_Modified_Date_For_Reload__c.Date();
        d2=system.now().Date();
        t1=accc.Last_Modified_Date_For_Reload__c.Time();
        t2=system.now().Time();
        t3=t2-(1000*15);
        count++;
        accc.Dont_Reload__c='n';
        update accc;
        
        return null;
        
    }
  
    public integer getCount(){
        return count;
    }
    
    @Future(callout=true)
    public static void updateAccount(string id,string name) {
        acc =[select id,name,Reload_Status__c,billingstate,billingcity,billingStreet,billingpostalcode,BillingCountry,Street_Status__c,Street_Result__c,description from account where id =:id];
        //construct an HTTP request
        HttpRequest req = new HttpRequest();
        String Url = 'https://api.smartystreets.com/street-address?street='+acc.BillingStreet+'&city='+acc.billingcity+'&state='+acc.BillingState+'&zipcode='+acc.billingpostalcode+'&candidates=5&auth-id=0cbe4ea8-d757-443a-8eef-025c47037543&auth-token=qOZSJ5U3d8monXX8gJr6G5IuWgjhmCiEWtxhHGOINGDFWpV%2FR4Uu4RRMzEj8Yw8cbrTw0E4u01c3quRJMvLXog%3D%3D';
        Url = Url.replace(' ','+');
        String urll = Url;
        req.setEndpoint(Url);
        req.setMethod('GET');
        
       
        //send the request
        Http http = new Http();
        HttpResponse res = new HttpResponse();
        if(!Test.isRunningTest())
        res = http.send(req);
        else
        HttpResponse resp = new HttpResponse();
        updateHelper.inFutureContext = true;
        
        //check the response
        if (res.getStatusCode() ==200) {
             String response=res.getBody();
             if(response!='[]'){
                 acc.Street_Status__c ='ok';
                 acc.Description = 'Hello)))'+res.getBody();
                 acc.Reload_Status__c=False;
                 update acc;
              }else{
                  acc.Street_Status__c ='Fail';
                  acc.Description = 'Failed';
                  acc.Reload_Status__c=False;
                  update acc;
               }
     
        }else{
            acc.Street_Status__c ='Fail';
            acc.Description = 'Failed';
            acc.Reload_Status__c =False;
            update acc;
            System.debug('Callout failed: ' + res);
        } 
    }
    public void stoppolling(){
        
    }
}