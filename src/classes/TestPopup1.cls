public with sharing class TestPopup1 {

    public Boolean displayPopup {get;set;}

    public TestPopup1(ApexPages.StandardController controller) {

    }
    
    public void showPopup()
    {
        
    displayPopup = true;

    
    }
    
    public void closePopup() {
        displayPopup = false;
        
    }
    


}