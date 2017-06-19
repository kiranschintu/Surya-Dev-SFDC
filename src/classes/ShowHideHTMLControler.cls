public class ShowHideHTMLControler { 
    public ShowHideHTMLControler(ApexPages.StandardSetController controller) {}
    
    
      public  List<Contact> acc; 
      
   public List<Contact> getResults() {
        acc = [Select name,Mobilephone From Contact Limit 3];
        return acc;
        
    }
    public List<Contact> getResults1() {
        acc = [Select name,Mobilephone From Contact Limit 10];
        return acc;
        
    }
    static testmethod void testmehod1(){ 
      
      contact[] cc=new contact[]{
      new contact(lastname='surya'),new contact(lastname='surya')};
       
      ApexPages.StandardsetController strcontroller = new ApexPages.StandardsetController(cc);
     
      ShowHideHTMLControler shc = new ShowHideHTMLControler(strcontroller);
      shc.getResults();
      shc.getResults1();
    
   } 
}