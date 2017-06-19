public with sharing class convertobjpgcon {
    
    public Opportunity newOpp;
    public Account acc;
    public Contact con;
    public OpportunityContactRole ocr;
    public ApexPages.StandardController CONTROL;
    public convertobjpgcon(ApexPages.StandardController controller) {
        this.CONTROL = controller;
    }
    
    public pageReference doCreateOpportunity() {
    
    newOpp = new Opportunity();
    acc = new Account();
    con = new Contact();
    ocr = new OpportunityContactRole();
    ConvertObj__c prospect = [select Id, Name, Company__c, Status__c from ConvertObj__c where id = :CONTROL.getId()];
    // add your field mappings here
    acc.Name = prospect.Company__c;
    insert acc;
    
    con.Lastname = prospect.Name;
    con.Accountid = acc.id;
    insert con;
    
    newOpp.Name = prospect.Name;
    newOpp.CloseDate = Date.today();
    newOpp.StageName = prospect.Status__c;
    newOpp.Accountid = acc.id;
    insert newOpp;
    
    ocr.Role = 'Business User';
    ocr.ISPRIMARY = TRUE;
    ocr.OPPORTUNITYID = newOpp.id;
    ocr.CONTACTID = con.id;
    insert ocr;   
    
    //con.lastname = prospect.Name;
    // etc.
    
    if (newOpp.id != null){
        Delete prospect;
    }
    pageReference p = new pageReference('/' + newOpp.id);
    p.setRedirect(true);
    return p;
     }

}