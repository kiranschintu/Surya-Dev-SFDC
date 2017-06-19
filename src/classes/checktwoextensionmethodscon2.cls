public with sharing class checktwoextensionmethodscon2 {

    public checktwoextensionmethodscon2(checktwoextensionmethodscon controller) {}
    
    public string getdisplay(){
        String result = 'Hello Extension Controller 2';
        return result;
    }
    public void dosome(){
    System.debug('###### In Extension Controller 2');
    }

}