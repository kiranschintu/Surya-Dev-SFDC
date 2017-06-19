public class SearchController {

   public String searchText{get;set;}
   public String searchText1{get;set;}
   List<AccountData__c> results;
   List<Account> results1;
   List<Id> lid = new List<Id>();
  /* public String getSearchText() {
      return searchText;
   }

   public void setSearchText(String s) {
      searchText = s;
   }*/

   public List<AccountData__c> getResults() {
      return results;
   }

   public PageReference doSearch() {
   
      //results = (List<AccountData__c>)[FIND :searchText+'*'IN ALL Fields RETURNING dhr__AccountData__c(id,AccountData__c.Name,Account__c )][0];
      //results = (List<Account>)[FIND :searchText+'*'IN ALL Fields RETURNING Account(id,name where id='0019000000O74Eq'),dhr__AccountData__c(id,AccountData__c.Name )][0];
    List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
    for(AccountData__c ad:results){
        lid.add(ad.Account__c);
    }
    results1 = [select id,name from account where id in:lid];
      return null;
   }
   
   public List<Account> getResults1() {
      return results1;
   }

}