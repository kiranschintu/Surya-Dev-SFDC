public class DynamicCustomVFComponentCTRL {
   public Account acc{get;set;}
   
   public DynamicCustomVFComponentCTRL(){
     if(acc==null){
        acc = new Account();
     }
   }
   
   public ApexPages.Component getMyCustomComponent() {
    Component.c.CustomComponent cuComponent = new Component.c.CustomComponent(myAcc=acc);
    //if(cuComponent==null){
        //cuComponent = new Component.c.CustomComponent(myAcc=acc);
    //}
    return cuComponent;
  }
  
    public pageReference doSome(){
        try{
            insert acc;
        }catch(Exception e){
            
        }
        return null;
    }
}