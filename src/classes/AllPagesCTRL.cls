public class AllPagesCTRL {

    public Account acc{get;set;}
    
    public AllPagesCTRL(ApexPages.StandardController controller) {
        acc = (Account)controller.getRecord();
        fetchRecord();

    }

    public void fetchRecord(){
        
    }
    
    public PageReference doSome(){
        ProcessAccount ob = new ProcessAccount();
        ob.doSome(acc);
        fetchRecord();
        
        return null;
    }
}