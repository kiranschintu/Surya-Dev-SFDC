@RestResource(urlMapping='/P3_Custom_URL/*')
global with sharing class P3_Custom_URL
{
  @HttpGET
  global static void CustomUrl()
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
    
    //Retrieving URL parameters
    String keyId = RestContext.request.params.get('keyId');
    String Value = RestContext.request.params.get('value');
    Integer StatusCode = 200;
    String ResponseMessage = 'OK';
    
    List<URLContext> RResponse = new  List<URLContext>();
    try{
        RResponse = validateURL(keyId,Value);
        AccountSettings obj = new AccountSettings();
        obj.AccountSettings = RResponse;
        ResponseMessage = JSON.serialize(obj);
    }   
    catch(Exception e){
        StatusCode = 500;
        ResponseMessage = e.getMessage();
    }
    RestContext.response.StatusCode = StatusCode;
    RestContext.response.responseBody = Blob.valueOf(ResponseMessage);
  }
  //Retrieving Data from P3 Custom URL Object
  private static List<URLContext> validateURL(String keyId, String Value)
  {
    List<URLContext> listUrlContext = new List<URLContext>();
    List<P3_Custom_URL__c> urllist = new List<P3_Custom_URL__c>();
    Integer flag=0;
    try{
        urllist = [select P3_Custom_URL_Id__c, Name,P3_Custom_URL_Value__c from P3_Custom_URL__c];
    
    for(P3_Custom_URL__c cu: urllist)
    {
        flag++;
        //Preparing response
        URLContext uContext = new URLContext();
        uContext.keyId = cu.Name;
        uContext.Value = cu.P3_Custom_URL_Value__c;
        listUrlContext.add(uContext);
    }
    if(flag==0)
    {
        URLContext uContext = new URLContext();
        uContext.errors = 'No Data Found';
        listUrlContext.add(uContext);
        
    }
    }catch(Exception e){
        system.debug('Error Occured'+e.getMessage());
    }

    return listUrlContext ;
  }
  
  global class AccountSettings
  {
      public List<URLContext> AccountSettings {set;get;}
  }
  //class to hold response body
  global class URLContext
  {
    public String keyId;
    public String Value;
    public String errors;
  }
  }