global class DisplayAllRecords{
    global class AllAccounts{
        Webservice List<String> Name=new List<String>();
        Webservice List<String> Phone;
        Webservice List<String> Website;
    }
    
    webservice static List<AllAccounts> displayAllRecords(List<AllAccounts> Allacc){
        
        //List<AllAccounts> a=new List<AllAccounts>();
        AllAccounts a=new AllAccounts();
        List<Account> acc = [SELECT id,name,phone,website from Account limit 10];
        for(Account ac:acc){
            a.Name.add(ac.name);
            //a.phone=ac.phone;
            //a.website=ac.website;
            //Allacc.add(a);
        }
        return Allacc;
    }
}