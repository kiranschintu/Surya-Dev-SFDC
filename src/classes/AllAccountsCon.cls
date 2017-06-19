public class AllAccountsCon {
    public list<Account> acc{get;set;}
    public String aName{get;set;}
    public boolean isDone{get;set;}
    
    public AllAccountsCon(){
        acc = new List<Account>();
        acc = [select id,name from Account limit 100];
    }
    public void doSearch(){
        acc = [select id,name from Account limit 10];
    }
    
    public pageReference generatePDF(){
        PageReference pg = new PageReference('/apex/AllAccountsConPDF');
        pg.setRedirect(false);
        return pg;
    }
}