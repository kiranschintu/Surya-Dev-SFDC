public class AllContactsCon{
    public string accountId{get;set;}
    public List<Contact> contacts {get;set;}
    public string ConcourseDocGUID{get;set;}
    
    public AllContactsCon(){
    
    }
    
    public void getInit()
    {
        contacts = [select id,name,phone from Contact where AccountId =:accountId];
    }
    
    public PageReference doAction(){
        PageReference pg = new PageReference('https://google.com?id='+ConcourseDocGUID);
        pg.setRedirect(true);
        return pg;
    }
    
}