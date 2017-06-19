public with sharing class ItemSearchController {
 
  //private ApexPages.StandardController controller {get; set;}
  public List<Task> searchResults {get;set;}
  public string searchText {get;set;}
 
  // standard controller - could also just use custom controller
  public ItemSearchController(ApexPages.StandardController controller) { }
 
  // fired when the search button is clicked
  public PageReference search() {
    /*String qry = 'select id, subject,priority from Task ' +
      'where subject like \'%' + searchText + '%\'';*/
      searchResults = [SELECT Id,subject,priority from Task where priority =:(searchText)];
    //searchResults = Database.query(qry);
    return null;
  }

}