public class myclass{
    private  final Contact acct ;
    //private  final list<Contact> accts ;
        
    public myclass(ApexPages.StandardSetController controller) {
        this.acct = (Contact)controller.getRecord(); 
    }    
    
    public ApexPages.StandardSetController contactRecords {
        get {
            if(contactRecords == null) {
                contactRecords = new ApexPages.StandardSetController(
                    Database.getQueryLocator([SELECT MobilePhone FROM Contact limit 2]));
            }
            return contactRecords;
            
        }
        
        private set;
    }
    public List<Contact> getContacts() {
         return (List<Contact>) contactRecords.getRecords();
         
    }
    



/*public PageReference Send(){
    for(Contact c:accts){
     if(c.MobilePhone!=null){
            ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'This Account has a Name.'+acct.MobilePhone);
             ApexPages.addMessage(noMobileMsg);
            return new ApexPages.StandardController(c).view(); 
             
             }
        else{
            ApexPages.Message noMobileMsg = new ApexPages.Message(ApexPages.severity.Info, 'This Account does not have a Name.'+acct.MobilePhone);
             ApexPages.addMessage(noMobileMsg);
             return null;
        }
        }return null;
   
}*/

}