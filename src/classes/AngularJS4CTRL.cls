public class AngularJS4CTRL{
    public string jsonData{get;set;}
    public Account acc{get;set;}
    
    public AngularJS4CTRL(){
        acc = new Account();
        List<Account> accs = [select Name,Rating from Account where Rating!=null order by createdDate limit 100];
        jsonData = JSON.serializePretty(accs);
        //jsonData = '[{name:\'Jani\',country:\'Norway\'},{name:\'Hege\',country:\'Sweden\'},{name:\'Kai\',country:\'Denmark\'}]';
    }
    
    public void doSome(){
        update acc;
    }
}