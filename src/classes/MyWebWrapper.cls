global class MyWebWrapper{
  
   //Define an object in apex that is exposed in apex web service
   global class WebWraper {
      /*webservice*/global String name;
      webservice String phone;
      webservice String aid;
   }

   webservice static WebWraper createAccountPlan() {
       Account acc = [select id,name,phone from Account where name!=null AND phone!=null limit 1];       
       WebWraper webw = new WebWraper();
       webw.name = acc.name;
       webw.phone = acc.phone;
       webw.aid = acc.id;
       return webw;
  }
  

}