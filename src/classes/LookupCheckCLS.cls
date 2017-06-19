public class LookupCheckCLS {
    public Contact con{get;set;}
    public String AccId{get;set;}
    public LookupCheckCLS(ApexPages.StandardController controller) {
        //con = (Contact)controller.getRecord();
        if(con==null)
        con = new Contact();
    }
    public void docheck(){
        system.debug('Contact is >>>'+con);
        system.debug('Account Id is >>>'+AccId);
    }

}