public class DisplayAllAccountsControllerExtension1 {
    public List<Account> accountss{get;set;}
    
    public DisplayAllAccountsControllerExtension1(DisplayAllAccountsController controller) {
        accountss = [select id,Name,lastModifiedDate from Account limit 10];
    }
}