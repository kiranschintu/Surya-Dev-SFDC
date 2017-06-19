@isTest
private class TestUpdateAccountAsVeteran
{
    
    
    private testMethod static void UpdateAccount()
    {
        account acc = new account();
        acc.name = 'ravisfdc';
        insert acc;
        list<contact> ucon = new list<contact>();
        contact con = new contact();
        con.lastname = 'Test';
        con.Contact_Type__C = 'Lead Owner';
        con.accountid=acc.id;
        ucon.add(con);
        insert ucon;
        update ucon;
        delete ucon;
        //UpdateAccountAsVeteran.makeAccVeteran();
               
    }
    
}