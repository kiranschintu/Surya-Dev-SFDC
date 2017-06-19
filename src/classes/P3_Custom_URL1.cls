@RestResource(urlMapping='/P3_Custom_URL1/*')
global with sharing class P3_Custom_URL1
{
  
  @HttpPost
    global static void doPost(myownclass myowncls) {
       
       
            Account account = new Account();
            account.Name = myowncls.name;
            account.phone = myowncls.phone;
            
       List<Account> acc = [select id,name,phone from Account where name=:myowncls.name];
        //insert accounts;
        //return 'success';
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(acc[0]));
    }
  
  global class myownclass{
      public String name;
      public String phone;
      public String errors;
  }
  
  /*@HttpPOST
  
  global static void CustomUrl(List<URLContext> responseList)
  {
    RestContext.response.addHeader('Content-Type', 'application/json');
    
    try
    {
      if(responseList!=null)
      {
        validateURL(responseList);
      }
      
      RestContext.response.responseBody = Blob.valueOf(JSON.serialize(responseList));
    }
    catch(Exception e)
    {
      URLContext errorResponse = new URLContext(e.getMessage());
      
      RestContext.response.responseBody = Blob.valueOf(JSON.serialize(errorResponse));
    }
    
  }
  
  private static void validateURL(List<URLContext> contextItem)
  {
    for(URLContext u : contextItem)
    {
      getCustomURL(u);
    }
  }
  
  private static void getCustomURL(URLContext contextItem)
  {        
            Account urllist = [Select name,phone From Account where Name = :contextItem.keyId limit 1];
            
            contextItem.keyId = urllist.Name;
            contextItem.Value = urllist.phone;
  }
  
  global class URLContext
  {
    public String keyId;
    public String Value;
    public String errors;
    public URLContext(String errors_msg)
    {
      errors = errors_msg;
    }
  }
  */
}