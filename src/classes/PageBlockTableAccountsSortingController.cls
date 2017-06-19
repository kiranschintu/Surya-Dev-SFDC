public class PageBlockTableAccountsSortingController{
    public List<Account> accounts{get;set;}
    public PageBlockTableAccountsSortingController(){
        accounts = [select id,name,phone,rating,CreatedBy.Name,CreatedDate  from Account limit 200];
    }
}