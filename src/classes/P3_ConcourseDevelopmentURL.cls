@RestResource(urlMapping='/P3_ConcourseDevURL/*')
global with sharing class P3_ConcourseDevelopmentURL
{
  @HttpGET
  global static void CustomUrl()
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
    
    //Reading URL parameters
    String urlName= RestContext.request.params.get('name');
    Integer StatusCode = 200;
    String ResponseMessage = 'OK';
    try{
    if(urlName!=null && urlName!=''){    
        ConcourseURLs response = new ConcourseURLs();
        //Retrieving the URL from custom settings based on parameter(urlName)
        response = retrieveMatchedURL(urlName);
        if(response!=null){
            ResponseMessage = JSON.serialize(response);
        }else{
            ResponseMessage = 'null';
        }
        StatusCode = 200;
    }else{

        //retrieving all Custom Settings if parameter not provided 
        List<ConcourseURLs> responses = new List<ConcourseURLs>();
        responses = retrieveURLs();
        
        if(responses!=null){
            ResponseMessage = JSON.serialize(responses);
        }else{
            ResponseMessage = 'null';
        }
        StatusCode = 200;
    }
	}catch(Exception e){
		system.debug('Error Occured :'+e.getMessage());
        StatusCode = 500;
        ResponseMessage = e.getMessage();
	}
    RestContext.response.StatusCode = StatusCode;
    RestContext.response.responseBody = Blob.valueOf(ResponseMessage);
    
  }
  
  //Retrieving all custom settings
  private static List<ConcourseURLs> retrieveURLs()
  {
    List<ConcourseURLs> curls = new List<ConcourseURLs>();
    
    Map<String,dhr__Dev_Configuration__c> custmSetngs = dhr__Dev_Configuration__c.getAll();
    
    for(String s:custmSetngs.keySet()){
        ConcourseURLs curl = new ConcourseURLs();
        curl.Name=s;
        curl.ConcourseServerURL = custmSetngs.get(s).dhr__Concourse_Server_URL__c;
        
        curls.add(curl);
    }
    
    return curls;
  }
  
  //searching custom settings for matched URL Name
  private static ConcourseURLs retrieveMatchedURL(String urlName)
  {
    ConcourseURLs curls = new ConcourseURLs();
    
    //Retrieve custom settings
    Dev_Configuration__c oc = Dev_Configuration__c.getInstance(urlName);
    ConcourseURLs curl = new ConcourseURLs();
    
        if(oc!=null){
            //preparing response
            curl.Name=oc.Name;
            curl.ConcourseServerURL = oc.dhr__Concourse_Server_URL__c;    
        }else{
            curl.errors='No values found';
        }
    
    return curl;
  }
  
  //class to hold the response body
  global class ConcourseURLs
  {
    public String Name;
    public String ConcourseServerURL;
    public String errors;
  }
}