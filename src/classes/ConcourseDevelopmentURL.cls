@RestResource(urlMapping='/ConcourseDevURL/*')
global with sharing class ConcourseDevelopmentURL
{
  @HttpGET
  
  global static void CustomUrl()
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
    
    String urlName= RestContext.request.params.get('name');
    
    if(urlName!=null && urlName!=''){    
        ConcourseURLs response = new ConcourseURLs();
        response = retrieveMatchedURL(urlName);
        
        try{
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(response));
        }catch(Exception e){
            system.debug('Error Occured :'+e.getMessage());
        }        
    }else{

        List<ConcourseURLs> responses = new List<ConcourseURLs>();
        responses = retrieveURLs();
        
        try{
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(responses));
        }catch(Exception e){
            system.debug('Error Occured :'+e.getMessage());
        }
    }
    
  }
  
  private static List<ConcourseURLs> retrieveURLs()
  {
    List<ConcourseURLs> curls = new List<ConcourseURLs>();
    
    Map<String,dhr__Dev_Configuration__c> cstngs = dhr__Dev_Configuration__c.getAll();
    
    for(String s:cstngs.keySet()){
        ConcourseURLs curl = new ConcourseURLs();
        curl.Name=s;
        curl.ConcourseServerURL = cstngs.get(s).dhr__Concourse_Server_URL__c;
        
        curls.add(curl);
    }
    
    return curls;
  }
  
  private static ConcourseURLs retrieveMatchedURL(String urlName)
  {
    ConcourseURLs curls = new ConcourseURLs();
    
    Dev_Configuration__c oc = Dev_Configuration__c.getInstance(urlName);
    ConcourseURLs curl = new ConcourseURLs();
    
        if(oc!=null){
            
            curl.Name=oc.Name;
            curl.ConcourseServerURL = oc.dhr__Concourse_Server_URL__c;    
        }else{
            curl.errors='No values found';
        }
        
       
    
    return curl;
  }
  
  global class ConcourseURLs
  {
    public String Name;
    public String ConcourseServerURL;
    public String errors;
  }
  }