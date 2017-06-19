public class multiAccountInsert{
    
             
    public List<Account> accts {get; set;}
    public Integer selectedRowIndex{get;set;}
   // public Integer recCount{get;set;}
  
    public multiAccountInsert(){
    
    accts = new List<Account>();
    
    //for (integer i = 0; i < 3; i++)
   //     {
        
         //recCount=0;
         
        Account acc = new Account();
        
        accts.add(acc);
        
        
       // }
        
    }
    
    public void addrow(){
    
   // recCount +=1;
        accts.add(new Account());
    }
    public void deleterow(){
    
    
    String dd=system.CurrentPageReference().getParameters().get('rowToBeDeleted');    
    Integer d=Integer.valueOf(dd);
    accts.remove(selectedRowIndex);
    //recCount -= 1;
    }
    
      
   
    public PageReference save(){
        insert accts;
        PageReference home = new PageReference('/home/home.jsp');
        home.setRedirect(true);
        return home;
    }
}