@isTest(seeAllData=True)
private class P3TestP3_ConcourseDevelopmentURL{
    private static testmethod void concoursdevURL(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/P3_ConcourseDevURL';  
        req.httpMethod = 'GET';
        req.addParameter('name', 'Concourse Development URL');
        RestContext.request = req;
        RestContext.response = res;
        
        P3_ConcourseDevelopmentURL ami = new P3_ConcourseDevelopmentURL();
        P3_ConcourseDevelopmentURL.CustomUrl();
    }
    
    private static testmethod void concoursdevURL1(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/P3_ConcourseDevURL';  
        req.httpMethod = 'GET';
        //req.addParameter('name', 'Concourse Development URL');
        RestContext.request = req;
        RestContext.response = res;
        
        P3_ConcourseDevelopmentURL ami = new P3_ConcourseDevelopmentURL();
        P3_ConcourseDevelopmentURL.CustomUrl();
    }
    
    private static testmethod void concoursdevURL2(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/P3_ConcourseDevURL';  
        req.httpMethod = 'GET';
        req.addParameter('name', 'Test URL');
        RestContext.request = req;
        RestContext.response = res;
        
        P3_ConcourseDevelopmentURL ami = new P3_ConcourseDevelopmentURL();
        P3_ConcourseDevelopmentURL.CustomUrl();
    }
}