public with sharing class InputFileCls {
    public transient blob body{get;set;}
    public String name{get;set;}
    
    public InputFileCls(){}
    
    public pageReference doCheck(){
        system.debug('Body'+body);
        system.debug('Name'+name);
        body = null;
        return null;
    }
}