public class JQueryRequiredForTableCTRL {
    Public List<Account> accs{get;set;}
    
    public JQueryRequiredForTableCTRL(){
        accs = [select id,name,phone,rating from Account];
    }
}