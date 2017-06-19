public with sharing class redirect {

    Opportunity opp{get;set;}
    public redirect(ApexPages.StandardController controller) {
    opp=(Opportunity)controller.getRecord();
    }
    public pagereference Redirect()
    {
    String hostname = ApexPages.currentPage().getHeaders().get('Host');
    Schema.DescribeSObjectResult r = Opportunity.sObjectType.getDescribe();
    String keyPrefix = r.getKeyPrefix();
    String optyURL2 = 'https://'+hostname+'/'+keyPrefix+'/e?nooverride=1&retURL='+keyPrefix+'&scontrolCaching=1&RecordType='+ApexPages.currentPage().getParameters().get('RecordType');
     If(ApexPages.currentPage().getParameters().get('RecordType') == '01290000000kMS6')
     {
           pagereference pageref = new pagereference('/apex/InlineEditPage');
           pageref.setredirect(true);
           return pageref;
     }else{
         //string s='https://ap1.salesforce.com/006/e?nooverride=1&retURL=%2F006&scontrolCaching=1&RecordType=01290000000kMSB&ent=Opportunity';
         string s=optyURL2;
         pagereference pageref1 = new pagereference(s);
           pageref1.setredirect(true);
           return pageref1;
     }
     }
     
     public pagereference RedirectEdit()
    {
    String hostname = ApexPages.currentPage().getHeaders().get('Host');
    ID recId = ApexPages.currentPage().getParameters().get('id');
    Schema.DescribeSObjectResult r = Opportunity.sObjectType.getDescribe();
    String keyPrefix = r.getKeyPrefix();
    //https://ap1.salesforce.com/0019000000CJMUy/e?retURL=%2F0019000000CJMUy
    String optyURL2 = 'https://'+hostname+'/'+recId+'/e?nooverride=1&retURL='+recId+'&RecordType='+ApexPages.currentPage().getParameters().get('RecordType');
     If(opp.RecordTypeId=='01290000000kMS6')
     {
           pagereference pageref = new pagereference('/apex/oppEdit?id='+recId+'&RecordType='+ApexPages.currentPage().getParameters().get('RecordType'));
           pageref.setredirect(true);
           return pageref;
           //return null;
     }else{
         //string s='https://ap1.salesforce.com/006/e?nooverride=1&retURL=%2F006&scontrolCaching=1&RecordType=01290000000kMSB&ent=Opportunity';
         string s=optyURL2;
         pagereference pageref1 = new pagereference(s);
           pageref1.setredirect(true);
           //return null;
           return pageref1;
     }
}

}