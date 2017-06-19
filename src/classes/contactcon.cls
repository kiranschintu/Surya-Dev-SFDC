public class contactcon {

    public Boolean check{get;set;}
    public Boolean check2{get;set;}
    public Contact con{get;set;}
    public Contact conn;
    public contactcon(ApexPages.StandardController controller) {
        this.conn = (Contact)controller.getRecord();
    }
    public PageReference save(){
    conn = new contact();
    if(check==true){
        conn.lastname = con.lastname;
        update conn;
    }
    if(check2==true){
        conn.lastname = con.lastname;
        update conn;
    }
    return null;
    }
    /*@isTest
    private static void testcontactcon(){
    Contact con = new Contact(lastname='sdfsdf');
    insert con;
    ApexPages.StandardController cont = new ApexPages.StandardController(con);
    contactcon ob = new contactcon(cont);
    ob.check=true;
    ob.save();
    
    }*/

}