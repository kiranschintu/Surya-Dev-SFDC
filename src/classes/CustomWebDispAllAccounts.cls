global class CustomWebDispAllAccounts
{
    
    webService static List<Opportunity> Displaying() 
    {
        List<Opportunity> acc ;
        acc = [select name,CloseDate,Accountid from Opportunity];
        return acc;
    }
    webService static List<Opportunity> Search(String searchText)
    {
        List<Opportunity> op;
        op = (List<Opportunity>)[FIND :searchText+'*' RETURNING Opportunity(Name)][0];
        return op;
    }
    
}