public class tstpopup {     

    public boolean displayPopup {get; set;}    
    public boolean image{get;set;} 
    
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    public void showImage() {        
        image = true;    
    }
    
    public void Import() {        
        image = true;
        displayPopup = false;    
    }
    
  }