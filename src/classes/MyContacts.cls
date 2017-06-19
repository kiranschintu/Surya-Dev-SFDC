@RestResource(urlMapping='/Contacts/*')
global with sharing class MyContacts{
    @HttpGet
    global static List<Contact> doGet(){
        RestRequest req = RestContext.request;
        String username=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        if(username!='Contacts')
        return getContact(username,req);
        else
        return getContacts(req);
    }
    private static List<Contact> getContact(String username,RestRequest req){
        // default fields to return 
        String qryFields='id,name';
        if (req.params.containsKey('fields')) qryFields = req.params.get('fields');
        return Database.query('select ' + qryFields + ' from Contact where Name = \'' + username +'\'');
        
    }
    private static List<Contact> getContacts(RestRequest req) { 
    
    // TODO - implement pagination /members?limit25&offset=50
    // TODO - implement variations /members?color=red-state=running
    
    // default fields to return 
    String qryFields = 'id, name';
    // default query limit   
    String qryLimit = 'limit 100';   
    // default order by
    String qryOrderby = '';      
    // default where clause
    String qryWhere = '';  
      
    // set the fields to return
    if (req.params.containsKey('fields')) qryFields = req.params.get('fields');
    // set the limit for records to return
    if (req.params.containsKey('limit')) qryLimit = 'limit ' + req.params.get('limit'); 
    // set the order by
    if (req.params.containsKey('orderby')) qryOrderby = 'order by ' + req.params.get('orderby');
    // set the where clause to search by username
    if (req.params.containsKey('search')) qryWhere = 'where Name LIKE \'' + req.params.get('search') +'%\'';
      
    return Database.query('select ' + qryFields + ' from Contact ' + qryWhere + ' ' + qryOrderby + ' ' + qryLimit);
    
  }
}