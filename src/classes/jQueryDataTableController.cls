public class jQueryDataTableController {
//This list will be bound to our datatable
   public List<accountWrapper> accountWrapperList {get; set;}
//This list will hold our “Account” query results
   public List<Account> accounts {get; set;}
   //Constructor
   public jQueryDataTableController(){
       //Instantiate account list in the constructor
       accountWrapperList = new List<accountWrapper>();
       //Add one row to the datatable by default when the page loads
       accountWrapperList.add(new accountWrapper(new Account()));
   }
//This action is called when the user clicks “Add Row”
   public PageReference addRow(){
       accountWrapperList.add(new accountWrapper(new Account()));
       return null;
   }
   //Wrapper class
   public class accountWrapper
   {
       public accountWrapper(Account accountObj){
           actualAccount = accountObj;
           hasRating = false;
       }
       public Account actualAccount {get; set;}
       public Boolean hasRating {get; set;}
   }
}