public class DispExtension {
    public Contact con{get;set;}
    public DispExtension(ApexPages.StandardController controller) {
        con = (Contact)controller.getRecord();
    }
    
    public void UpdateAcc(){
        if(con.get('phone')!=null){
            system.debug('Hello::'+con.get('phone'));
            update con;
        }
    }

}