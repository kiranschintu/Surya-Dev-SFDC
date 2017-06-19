@RestResource(urlMapping='/P3_RequestStatus/*')

global with sharing class P3_RequestStatusController 
{
  @HttpGet
  
  global static void getRequestStatus()
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
        
    Integer statusCode = 200;
    String responseMessage = 'OK';
    try
    {
      List<WrapperResults> requestStatusList = getRequestStatusList();
          statusCode = 200;
      responseMessage = JSON.serialize(requestStatusList);
    }
    catch(Exception e)
    {
      statusCode = 500;
      responseMessage = e.getMessage();
    }
    
    RestContext.response.statusCode = statusCode;
    RestContext.response.responseBody = Blob.valueOf(responseMessage);
  }
  
  private static List<WrapperResults> getRequestStatusList()
  {
    List<AggregateResult> requestStatusList = new List<AggregateResult>(); 
    requestStatusList = [SELECT dhr__Status__c,Count(Name) statuscount FROM Work_Product__c GROUP BY Status__c];
    
    List<WrapperResults> wrprds = new List<WrapperResults>();
    
    Set<String> statusvals = new Set<String>();
    
    for(AggregateResult ag : requestStatusList){
        statusvals.add(String.valueOf(ag.get('dhr__Status__c')));
    }
    
    Map<String,List<Work_Product__c>> wrprodsMap = new Map<String,List<Work_Product__c>>();
        
    for(Work_Product__c wp : [select id,name,Status__c,Work_Product_Name__c from Work_Product__c where Status__c in:statusvals]){
        
        if(wrprodsMap.containsKey(wp.Status__c)){
            List<Work_Product__c> wps = new List<Work_Product__c>();
            wps = wrprodsMap.get(wp.Status__c);    
            wps.add(wp);
            
            wrprodsMap.put(wp.Status__c,wps);
        }else{
            List<Work_Product__c> wps = new List<Work_Product__c>();
            wps.add(wp);    
            wrprodsMap.put(wp.Status__c,wps);
        }
    }
    
    for(AggregateResult ag : requestStatusList){
        WrapperResults wrs = new WrapperResults();
        wrs.Status = String.valueOf(ag.get('dhr__Status__c'));
        wrs.Count = String.valueOf(ag.get('statuscount'));
        if(wrprodsMap.containsKey(wrs.Status)){
            wrs.workproducts = wrprodsMap.get(wrs.Status);
        }
        wrprds.add(wrs);
    }
    
    return wrprds;
  }
  
  global class WrapperResults{
    String Status;
    String Count;
    List<Work_Product__c> workproducts;
  }
  
}