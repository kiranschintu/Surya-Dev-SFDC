public class JQueryPaginationController {
    public list<Contact> cons{get;set;}
    
    public JQueryPaginationController(){
        cons = [select id,name,Email from Contact limit 100];
    }
}