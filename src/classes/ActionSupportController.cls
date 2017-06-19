public class ActionSupportController {
    public Account acc{get;set;}
    public List<SelectOption> options{get;set;}
    public String selectedValue{get;set;}
    public List<String> multiSelevals{get;set;}
    public List<Account> accounts{get;set;}
    
    
    public ActionSupportController(){
        acc = new Account();
        multiSelevals = new List<String>();
        accounts = new List<Account>();
        options = new List<SelectOption>();
        options.add(new SelectOption('Hot','Hot'));
        options.add(new SelectOption('Warm','Warm'));
        options.add(new SelectOption('Cold','Cold'));
    }
    public void doSome(){
        system.debug('multiSelevals>>>'+multiSelevals);
        accounts = [select id,name from Account where Rating IN:multiSelevals];
    }
}