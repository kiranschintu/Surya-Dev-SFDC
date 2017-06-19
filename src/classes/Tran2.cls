public class Tran2 {
    
    Public Account account{get;set;}
    public Tran2(ApexPages.StandardController controller) {
        this.account = (Account)controller.getRecord();
    }
    public Account records(){
       
        return account;
    }

}