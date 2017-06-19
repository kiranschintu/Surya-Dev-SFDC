public class SubmitCaseController {

    

    
    public Case c { get; set; }
    
    public SubmitCaseController(ApexPages.StandardController controller) {
c = new Case();
    }
    
    
    
    public PageReference submitCase() {
            c = new Case(SuppliedName = c.SuppliedName,origin='web');
             
             INSERT c;
                return new PageReference('/thanks');
            } 
           
       
    
}