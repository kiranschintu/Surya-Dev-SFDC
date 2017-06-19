@RestResource(urlMapping='/RESTAPIDataService/*')
  global with sharing class RESTAPIData 
{
    @HttpPost
    global static void RESTAPIDetails(String aName) 
    { 
        Account result = new Account();
        result.name=aName;
        
        insert result ;
    }
}