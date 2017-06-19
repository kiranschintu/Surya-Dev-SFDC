public class SelectActionController {

    public SelectActionController() {

    }

    ApexPages.StandardsetController setCon;
    public SelectActionController(ApexPages.StandardSetController controller) {
      setCon = controller;
    }
   
     public pageReference doSomething()
    {
        for ( contact acc :(contact[])setCon.getSelected())
        {
        }
        return null;
    }
  
 

}