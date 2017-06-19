public with sharing class OppVerticalCon {
    
    public List<Account> accounts{get;set;}
    public List<Opportunity> opp{get;set;}
    public OppVerticalCon(){
        accounts = [select name,(select closedate,ExpectedRevenue from Opportunities) from Account];
        opp = [select id,name,closedate,ExpectedRevenue from Opportunity];
        
    }
}