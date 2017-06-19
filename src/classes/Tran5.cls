public class Tran5 {

    public Account account{get;set;}
    public Tran5(ApexPages.StandardController controller) {
        this.account = (Account)controller.getRecord();
    }
    /*public PageReference DoSave(){
        account.Name=account.Name;
        insert account;
        //PageReference pg = new ApexPages.StandardController(account).view();
        PageReference pg = new PageReference('/apex/Tran4');
        
        
        return pg;
    }*/
public Account DoSave(){
        account.Name=account.Name;
        insert account;
        //PageReference pg = new ApexPages.StandardController(account).view();
        PageReference pg = new PageReference('/apex/Tran4');
        
        
        return null;
    }

}