public class contactconex {
public Contact con{get;set;}
    public contactconex(ApexPages.StandardController controller) {
      this.con = (Contact)controller.getRecord();  
    }
    public void saving(){
        try{insert con;}catch(exception e){}
       // try{update con;}catch(exception e){}
        //return Null;
    }

}