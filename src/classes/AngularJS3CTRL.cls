global class AngularJS3CTRL{
    public string name{get;set;}
    public List<String> names{get;set;}
    public List<Account> accounts{get;set;}
    public AngularJS3CTRL(){
        name='Hello Angular JS';
        names = new List<String>();
        names.add('Surya');
        names.add('Kiran');
        names.add('Rahul');
        
        accounts = [select id,name,phone,rating,annualRevenue from Account limit 3];
    }
    
    @RemoteAction
    global static String getAcc(string name){
        Account acc = [select id,name,phone,rating,annualRevenue from Account limit 1];
        string response = JSON.serialize(acc);
        return response;
    }
}