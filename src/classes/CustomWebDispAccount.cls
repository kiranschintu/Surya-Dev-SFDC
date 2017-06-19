global class CustomWebDispAccount
{
    webService static Contact Login(String Email,String pwd) 
    {
        Contact acc = new Contact();
        acc = [select firstname,lastname,Account.name,phone,email from Contact where Email =:Email and Password__c =: pwd];
        return acc;
    }
    webService static contact Updating(String id,String fname,String lname,String phone) 
    {
        Contact acc = new Contact();
        acc = [select firstname,lastname,Account.name,phone,email from Contact where id=:id];
        acc.firstname = fname;
        acc.lastname = lname;
        acc.phone = phone;
        update acc;
        return null;
    }
}