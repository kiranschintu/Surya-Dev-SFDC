public with sharing class checktwoextensionmethodscon1 {

    public checktwoextensionmethodscon1(checktwoextensionmethodscon controller) {}
    
    public string getdisplay(){
        String result = 'Hello Extension Controller 1';
        return result;
    }
    public void dosome(){
    System.debug('###### In Extension Controller 1');
    }

}