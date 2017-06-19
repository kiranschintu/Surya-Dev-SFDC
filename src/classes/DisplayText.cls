@RestResource(urlMapping='/displayrecord/*')
global class DisplayText{
    
    @HttpGet
    global static Account displayRecord(){
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountname = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        accountname=accountname.replace('%20',' ');
        accountname=accountname.trim();
        Account acc = [SELECT id,name,phone,website,dhr__Image1__c from Account where Name=:accountname limit 1];
        
        return acc;
        //return 'Details : '+acc.name+';'+acc.phone+';'+acc.website;
    }
    
}