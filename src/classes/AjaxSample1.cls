public class AjaxSample1 {
    
    public List<Contact> con;
    public Contact acc;
    public Integer Refresh1{get;set;}
    
    public List<Contact> getContactRecords(){
        
        con = [SELECT Name,Account.Name from Contact LIMIT 3];
        return con;
    }
    
    public Account getAccountRecord(){
    
        //Id id = System.currentPageReference().getParameters().get('id');
        Id aid = ApexPages.currentPage().getParameters().get('aid');
        if(aid!=Null)
        Refresh1=1;
        return aid == null ? new Account() : [SELECT Id, Name FROM Account WHERE Id = :aid];
      
    }
    public Contact getContactRecord(){
    
        Id id = System.currentPageReference().getParameters().get('id');
        //Id id = ApexPages.currentPage().getParameters().get('id');
        return id == null ? new Contact() : [SELECT Id, Name FROM Contact WHERE Id = :id];
      
    }
}