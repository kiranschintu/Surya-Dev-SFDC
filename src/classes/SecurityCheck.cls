public with sharing class SecurityCheck{
    public List<Lead> leads{get;set;} 
    public SecurityCheck(){
        //leads = [select id,name from lead];
        //leads = SecurityCheckChild.doTest();
        SecurityCheckWrapper ob = new SecurityCheckWrapper();
        leads = ob.wrpaTest();
        
    }
    public void test(){
        Lead l = [Select id,LastName,Email,Phone,description from Lead where id='00Q9000000DNdZS'];
        l.description = 'I am Test User';
        update l;
    }
    public without sharing class SecurityCheckWrapper{
        public List<Lead> wrpaTest(){
            return [select id,name from lead];
        }
    }
}