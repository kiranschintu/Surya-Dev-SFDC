global with sharing class ADMAKnowledgeLab{
    
    global class Contactinfo{
        Webservice String salutation;
        Webservice String FN;
        Webservice String LN;
        Webservice String Email;
        Webservice String Pwd;
        Webservice Boolean gender;
        Webservice String url;
        Webservice String img;
        
    }
    
    public static String checking(String email){
    if(email ==Null)
    return 'Email Can not be null';
    else
    return 'Check you Email';
    }
    
    global class Plan{
        
        Webservice String Email;
        Webservice String password;
        Webservice String LName;
           
    }
    
    webservice static Plan createAccountPlan(Plan vPlan) {
       
     //checking(vplan.email);
     
       Contact conn ;
       try{
      
      conn = [SELECT lastname,Member__c,PwdConfirmed__c,TempForgotPwd__c,Time_Stamp__c,TmpMember_Status__c,Last_Login_Date_Time__c,Account.name,Account.Business_Activity__c,Account.Industry,phone from contact where email =:vplan.email and Password__c=:vplan.password];
          
        /*  if(conn.Member__c == True){
       
         conn.PwdConfirmed__c =False;
         conn.TempForgotPwd__c =Null;
         conn.TmpMember_Status__c =False;
         conn.Time_Stamp__c =Null;
         conn.Last_Login_Date_Time__c =System.NOW();
         update conn;
         return conn;
         
         }else
         return null;
        */
        vPlan.LName = conn.lastname;
        return vPlan;
   }catch(Exception e){
   return null;
   }
       
       
       
       
       /*Account acct = new Account();
       acct.Name = vPlan.name;
       acct.AccountNumber = String.valueOf(vPlan.planNumber);
       insert acct;
       
       vPlan.planId=acct.Id;
       return vPlan;*/
       //return null;
  }
    
    
    public static String tokenM;
    public static String passwordgenerator(){
        Integer len = 15;
        Blob blobkey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobKey);
        tokenM = key.substring(0,len).toUpperCase();
        return tokenM;
    }
    
    webservice static String Registration(Contactinfo info){
        Contact con = new Contact();
        Account ac = new Account();
        //List<Contact> conn;
                con.Salutation =info.salutation;
                con.firstName =info.FN;
                con.lastName =info.LN;
                con.Email =info.Email;
                con.Password__c =info.pwd;
                con.Male__c =info.gender;
                con.Time_Stamp__c =system.now()+1;
                con.image__c = info.img;
        
        String splitEmail = info.Email.split('\\@')[1];
        
        //Checking Email Duplication
        //conn = [select email,TmpMember_Status__c,Exp_Actv_Time__c,Time_Stamp__c,TempForgotPwd__c from contact];
        Integer count = 0;
        for(contact c:[select email,TmpMember_Status__c,Exp_Actv_Time__c,Time_Stamp__c,TempForgotPwd__c from contact]){
        if(c.email == info.email)
        count = 1;
        }
                
        if(count ==0){
        //Validating user with Member Compnay based on Email
        try{
        ac =[select id,name,Member_Status__c,Company_Email__c,Member_Ship_Type__c from Account where Domain__c like :'%'+splitEmail ]; 
        }catch(Exception e){
        //creating both Non-Member Account and Contact based on Email
                if(ac.id==Null){
                RecordType rt = [select id from RecordType where name ='Non-Member' limit 1];
                ac.recordtypeid =rt.id;
                //Account acc = new Account();
                ac.name =splitEmail;
                ac.Domain__c ='www.'+splitEmail;
                ac.Member_Ship_Type__c ='Non-Member';
                ac.Company_Email__c =info.email;
                insert ac;
                con.Accountid =ac.id;
                insert con;
                return 'Your company is Not a Member Company... <br/>please tell to become a Member';
                }else
                return Null;
        }
              if(ac.Member_Ship_Type__c != 'Non-Member'){
                if(ac.Member_Status__c == 'Current' || ac.Member_Status__c == 'Overdue'){
                    con.Accountid = ac.id;
                    
                    
        //Generating Random Alphe-Numeric Number for Temp Pwd
        /*Integer len = 15;
        Blob blobkey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobKey);
        String token = key.substring(0,len).toUpperCase();*/
        passwordgenerator();
        con.TempForgotPwd__c = tokenM;
        
        //String token = 'S'+(Integer)(Math.random()*1000000);
        DateTime tstamp = con.Time_Stamp__c+1;
        //inserting contact;
        insert con;
        
        //create a mail object to send a single email.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(con.id);
        mail.setSenderDisplayName('SF.com Email Agent');
        EmailTemplate et =[select ID,name,developername from emailtemplate where developername ='Member_Activation'];
        mail.setTemplateId(et.id);
        
        //send the email
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );
        if(results[0].isSuccess()){
           return 'Thanks for Regestering.. Please check your Mail';
        }else
        return 'Email Doesnot send';
                
                }else{
                    return 'Your Company is Lapsed. Please ask your Manager';
                }
                }else{
                    return 'your Company is Not a Member Company';
                }
           }
        
        else{
            return 'Knowledge Lab Login for this email already exists. If you forgot your password then click on Forgot Password Link';
        }
     
    }
    
   webservice static String RegistrationCnfm(String token){
        Contact con = new Contact();
        if(token =='')
        token =Null;
        //List<Contact> conn;
        if(token!=Null){
        try{
        con = [select id,email,Member__c,Exp_Actv_Time__c,TmpMember_Status__c,Time_Stamp__c,Password__c,TempForgotPwd__c from Contact where dhr__TempForgotPwd__c =:token];
        }catch(Exception e){
        return 'No Contact Exists';
        }
        if(con.TempForgotPwd__c==token ){
        
        //Generating Random Alphe-Numeric Number for Temp Pwd
        /*Integer len = 15;
        Blob blobkey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobKey);
        String tokenn = key.substring(0,len).toUpperCase();
        */
        passwordgenerator();
        //create a mail object to send a single email.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTargetObjectId(con.id);
        mail.setSenderDisplayName('SF.com Email Agent');
        mail.setTemplateId('00X90000001ES9a');
        
        //send the email
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );
        if(results[0].isSuccess()){
           con.Member__c = True;
           con.Password__c = tokenM;
           con.TempForgotPwd__c =Null;
           update con;
           return 'Your Email is Verified.Please check your mail for Password';
        }else
        return 'Email Doesnot send';
        }else
            return 'This Code is Expired';
        
        }else
        return 'Please Enter Something';
    }
    
    global class errors{
      webservice Integer ErrorCode;
      webservice String ErrorMsg;   
    }
    global class contactlogininfo{
    
        webservice String id;
        webservice String name;
        webservice String Email;
        webservice String Password;
        webservice String Company;
        Webservice errors error = new errors();
        
        
    }
  
    webservice static contactlogininfo Login(String email,String password){
      contactlogininfo cli = new contactlogininfo();
      
      contact conn = new Contact();
      conn = [SELECT lastname,Member__c,dhr__Password__c,PwdConfirmed__c,TempForgotPwd__c,Time_Stamp__c,TmpMember_Status__c,email,Last_Login_Date_Time__c,Account.name,Account.Business_Activity__c,Account.Industry,phone from contact where email =:email limit 1];
      
      if(conn.dhr__Password__c ==password){
      if(conn.Member__c == True){
       
         conn.PwdConfirmed__c =False;
         conn.TempForgotPwd__c =Null;
         conn.TmpMember_Status__c =False;
         conn.Time_Stamp__c =Null;
         conn.Last_Login_Date_Time__c =System.NOW();
         update conn;
         
         cli.id=conn.id;
         cli.name=conn.name;
         cli.email=conn.email;
         cli.Password=conn.TempForgotPwd__c;
         cli.Company=conn.Account.name;
         cli.error.ErrorCode=3003;//sucess
         cli.error.ErrorMsg='Sucess';
         
         return cli;
         
         }else{
         cli.error.ErrorCode=3002;//MD not Active
         cli.error.ErrorMsg='MD not Active';
         return cli;
         }
         }else{
         cli.error.ErrorCode=3001;//Incorrect Password
         cli.error.ErrorMsg='Incorrect Password';
         return cli;
         }
      
      /*try{
      
      conn = [SELECT lastname,Member__c,PwdConfirmed__c,TempForgotPwd__c,Time_Stamp__c,TmpMember_Status__c,email,Last_Login_Date_Time__c,Account.name,Account.Business_Activity__c,Account.Industry,phone from contact where email =:email];
          
          if(conn.dhr__Password_Encrypt__c=='123'){
       
         if(conn.Member__c == True){
       
         conn.PwdConfirmed__c =False;
         conn.TempForgotPwd__c =Null;
         conn.TmpMember_Status__c =False;
         conn.Time_Stamp__c =Null;
         conn.Last_Login_Date_Time__c =System.NOW();
         update conn;
         return conn;
         
         }else
         return null;
         }else
         return null;
        
   }catch(Exception e){
   return null;
   }*/
   
      }
    
    webservice static String forgotPassword(String email){
       
        
        Contact conn; //= new Contact();
        List<Contact> con;
        con = [select email,password__c,TempForgotPwd__c from contact where email =: email];
        if(con.isEmpty()){
            return 'No Contact Exists';
        }else{
        
        conn = con[0];
      /* Integer len = 15;
        Blob blobkey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobkey);
        String token = key.substring(0,len).toUpperCase();
        */
        passwordgenerator();
        String url = 'https://localhost:8080/ADMA/ChangePwd.jsp?token='+tokenM+'&email='+email;
       
        //create a mail object to send a single email.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        //String[] toAddresses = new String[] {conn.email};
        //mail.settoAddresses(toAddresses);
        mail.setTargetObjectId(conn.id);
        mail.setSaveAsActivity(True);
        mail.setSenderDisplayName('SF.com Email Agent');
        mail.setSubject('Forgot Password');
        mail.setHtmlBody('Click this Link <a href='+url+'> Click Here'+email+'</a>');
        //send the email
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } );
                
        if(results[0].isSuccess()){
           conn.TempForgotPwd__c = tokenM;
           update con;
           return 'Success. Email send to'+email;
        }else
        return 'Email Doesnot send';
        }
        
     }
    
    webservice static String forgotPasswordCnfm(String pwd,String email,string token){
        Contact con = new Contact();
        con = [select id,email,Password__c,TempForgotPwd__c from Contact where email =:email];
        if(con.TempForgotPwd__c==token){
        con.Password__c = pwd;
        con.PwdConfirmed__c = True;
        update con;
        return 'Password changed. Your Password is :'+pwd;
        }
        return 'This link is Expired';
    }
    
    @ReadOnly
    webservice static List<Account> SearchingAccount(String Company,String BActivity,String State){
        List<Account> accounts = new List<Account>();
        String searchText;
        if(Company =='')
        Company =Null;
        if(BActivity =='')
        BActivity =Null;
        else
        BActivity.replace('&amp;','&');
        if(State =='')
        State =Null;
        if(Company !=Null){
            if(BActivity !=Null && State!=Null && State =='International')
            accounts = [Select id,name,image__c,Business_Activity__c,Primary_User_of__c,BillingState from Account where (Name like :Company+'%' OR Trading_As__c like :Company+'%' ) AND Primary_User_of__c INCLUDES(:BActivity) AND BillingState =:State AND Member_Directory_Visible__c =True ORDER BY Name ASC];
            else if(BActivity !=Null && State==Null)
            accounts = [select id,name,image__c,Business_Activity__c,BillingState from Account where (Name like :Company+'%' OR Trading_As__c like :Company+'%' ) AND Primary_User_of__c INCLUDES(:BActivity) AND Member_Directory_Visible__c =True ORDER BY Name ASC];
            else if(BActivity ==Null && State!=Null)
            accounts = [select id,name,image__c,Business_Activity__c,Industry from Account where (Name like :Company+'%' OR Trading_As__c like :Company+'%' ) AND BillingState =:State AND Member_Directory_Visible__c =True ORDER BY Name ASC];
           else //if (BActivity == Null && Industry == Null)
            accounts = [select id,name,image__c,Business_Activity__c,Industry from Account where (Name like :Company+'%' OR Trading_As__c like :Company+'%' ) AND Member_Directory_Visible__c =True ORDER BY Name ASC];
            //accounts = (List<Account>)[FIND :searchText+'*' RETURNING Account(Name, Phone)][0]; 
        }
        else{
            
                if(BActivity !=Null && State !=Null)
                accounts = [Select id,name,image__c,Business_Activity__c,Industry from Account where Primary_User_of__c INCLUDES(:BActivity) AND BillingState =:State AND Member_Directory_Visible__c =True ORDER BY Name ASC];
                else if(BActivity !=Null && State ==Null)
                accounts = [select id,name,image__c,Business_Activity__c,Industry from Account where Primary_User_of__c INCLUDES(:BActivity) AND Member_Directory_Visible__c =True ORDER BY Name ASC];
                else if(BActivity ==Null && State !=Null)
                accounts = [select id,name,image__c,Business_Activity__c,Industry from Account where BillingState =:State AND Member_Directory_Visible__c =True ORDER BY Name ASC];
               
        }
        
        if(accounts.isEmpty())
        return null;
        else
        return accounts;
        
    }
    
    @ReadOnly
    webservice static Account ShowingAccount(String clickText){
        Account acc;
        acc = [Select name,image__c,image1__c,phone,fax from Account where Name =:clickText limit 1];
        String image = acc.image__c;
        Blob hash = Crypto.generateDigest('SHA1',Blob.valueOf(image));
        String hexDigest = EncodingUtil.base64Encode(hash);
        //if(acc.isEmpty())
        //return null;
        //else
        return acc;
    }
    
    @ReadOnly
    webservice static Account SelectWhosWho(String Rid){
        Account account;
        account = [select name,Phone,fax,Company_Email__c,Website,BillingStreet,BillingCity,BillingCountry,BillingState,BillingPostalcode,Industry,Trading_As__c from Account where id =:Rid limit 1];
        return account;
    }
   /* 
    global class Person {
 
        webservice String id;
        webservice String firstName;
        webservice String lastName;
        webservice String company;
        webservice String Email;
        webservice String phone;
        webservice String sObjectType;
 
    }
    
    //Using SOSl
    @ReadOnly
    webservice static List<Person> SearchingAccounts(String Email){
        List<Person> persons = new List<Person>();
        
        if(Email =='')
        Email =Null;
        
        //Issue the SOSL Search
        List<list<sobject>> searchResults = [FIND :email IN EMAIL FIELDS RETURNING
            Contact (Id, Account.Name, FirstName, LastName, Email, Phone),
            Lead (Id, Company, FirstName, LastName, Email, Phone)];
        
        //Cast the results by sObject type
        List<contact> contacts = ((List<contact>)searchResults[0]);
        List<Lead> leads = ((List<Lead>)searchResults[1]);
        
        //A each contact found as Person
        for(Integer i=0;i<contacts.size();i++){
        person p = new person();
        p.id=contacts[i].id;
        p.firstname=contacts[i].firstname;
        p.lastname=contacts[i].lastname;
        p.company=contacts[i].Account.name;
        p.email=contacts[i].email;
        p.phone=contacts[i].phone;
        p.sObjectType='Contact';
        persons.add(p);
        }
        //A each Lead found as Person
        for(Integer i=0;i<leads.size();i++){
        person p = new person();
        p.id=leads[i].id;
        p.firstname=leads[i].firstname;
        p.lastname=leads[i].lastname;
        p.company=leads[i].company;
        p.email=leads[i].email;
        p.phone=leads[i].phone;
        p.sObjectType='Lead';
        persons.add(p);
        }
        if(persons.isEmpty())
        return null;
        else
        return persons;
        
        
    }*/
}