@isTest
Private class Testcontactcon{
    private static testMethod void unitTest(){
        Contact con = new COntact();
        con.lastname='test';
        insert con;
        
        ApexPages.StandardController contrlr = new ApexPages.StandardController(con);
        contactcon  ob = new contactcon(contrlr);
        ob.check=true;
        ob.check2=true;
        ob.con=con;
        ob.save();
        
    }
}