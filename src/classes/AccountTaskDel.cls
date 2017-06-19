global class AccountTaskDel { 
WebService static void deleteAlltasks (Contact con) {
    //con =[select id,description from contact];
    HttpRequest req = new HttpRequest();
       req.setEndpoint('http://www.cheenath.com/tutorial/sfdc/sample1/data.txt');
              req.setMethod('GET');
       HttpResponse res = new Http().send(req);
      String h = res.getBody();
       if(res.getstatuscode()==200){
           con.description = h;
         }
        
        update con;
        
}
}