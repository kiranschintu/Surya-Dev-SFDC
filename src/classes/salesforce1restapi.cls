@RestResource(urlMapping='/salesforce1restapi/*')
global class salesforce1restapi{
    @HttpGet
    global static List<Case> getOperCases() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.addHeader('Access-Control-Allow-Origin','*');
        String companyName = RestContext.request.params.get('trend');
        Account company = [ Select ID, Name, Email__c, BillingState from Account where Name = :companyName];
        List<Case> cases = [SELECT Id, Subject, Status, OwnerId, Owner.Name from Case WHERE AccountId =: company.Id];
        return cases;
    }
}