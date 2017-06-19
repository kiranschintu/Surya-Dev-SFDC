public with sharing class bulkdataload {
    public string status{get;set;}
    public bulkdataload(){
    }
    
    public void createbulkjob(){
        
        String str = '"" + "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + "<jobInfo xmlns=\"http://www.force.com/2009/06/asyncapi/dataload\">" + "    <operation></operation>" + "    <object></object>" + "    <contentType>CSV</contentType>" + "</jobInfo>"';
        String url = 'https://ap1-api.salesforce.com/services/async/28.0/job';
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(url);
        req.setBody(str);
        String authorizationHeader = 'OAuth 00D90000000eMdC!AQsAQHOirts8EnCds28rNgjjfprrgsRCbIlMfv0SgFku2.HORyRY4JcZdPPy_QjdskBp14833gKrnn5j146kalfqlmvKWtYB ';
        req.setHeader('Authorization',authorizationHeader);
        HttpResponse res = h.send(req);
        if(res.getStatusCode()==200){
        status='sucess';
        }else
        status='fail'+res.getBody();
    }
}