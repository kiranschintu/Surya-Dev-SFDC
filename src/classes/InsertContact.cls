public class InsertContact {
    
    
    public Contact con{get;set;}
    List<Contact> conn;
    
    public InsertContact(){
        con = new contact();
        
    }
   
    public PageReference saving(){
    Integer count = 0;
    contact c = new contact(lastname=con.lastname,email=con.email);
       
       conn = [select id,lastname,email from contact];
       for(Contact cc:conn){
           if(cc.email==con.email)
           count =1;
           
       }if(count == 0)
       insert c;
       return null;
    }
}