@isTest
private class oppdata{
    static testmethod void testopp(){
    
    Opportunity[] opp = new Opportunity[]{
                                        new Opportunity(name='sample',StageName='prospecting',CloseDate=system.today(),Contact_Status__c='sample'),
                                        new Opportunity(name='sample1',StageName='prospecting1',CloseDate=system.today(),Contact_Status__c='sample1')
                                        };
    insert opp;
    
    Contact con = new Contact(lastname='xxx');
    insert con;
    
    OpportunityContactRole[] ocr= new OpportunityContactRole[]{
                                        new OpportunityContactRole(role='xxx',contactid=con.id,opportunityid=opp[0].id),
                                        new OpportunityContactRole(role='xxxx',contactid=con.id,opportunityid=opp[1].id)
                                        };
    insert ocr;
    
    
    opp[0].Contact_Status__c='hello';
         Test.startTest();
         update opp;
         Test.stopTest();
    
    ocr = [SELECT id, contactid,contact.status__c FROM OpportunityContactRole WHERE opportunityid =:opp[0].id];
         
    
    }
}