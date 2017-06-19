public with sharing class hidecon {
    
    public Opportunity opr;
    Public Account acc{get;set;}
    public Boolean check{get;set;}
    public hidecon(ApexPages.StandardController controller) {
        this.opr = (Opportunity)controller.getRecord();
        acc = new account();
        
    }
    
    public PageReference setFields(){
    
    acc = [select id,phone,description from account where id =:acc.id];
    acc.Phone = '......';

    acc.Description = '.....';

 

return null;

 

}
 
}