global class AccountUpdater {
    global static boolean stoprecursion=False;
  //Future annotation to mark the method as async.
  //@Future(callout=true)
  @Future(callout=true) 
  public static void updateAccount(String id, String name) {
   System.debug('hello');
   stoprecursion=true;
   //updateHelper.inFutureContext=true;
   Account acc =new Account(id=id);
      acc.Description = 'hello';
      update acc;
   /*
    //construct an HTTP request
    HttpRequest req = new HttpRequest();
    req.setEndpoint('http://cheenath.com/tutorial/sfdc/sample1/data.txt');
    req.setMethod('GET');

    //send the request
    Http http = new Http();
    HttpResponse res = http.send(req);
updateHelper.inFutureContext=true;
    //check the response
    if (res.getStatusCode() == 200) {

      //update account
      //Account acc =[select id,name,description from account where id =:id];
      Account acc =new Account(id=id);
      acc.Description = res.getBody();
      update acc;
    } else {
      System.debug('Callout failed: ' + res);
    }*/ 
  }
}