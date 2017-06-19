public with sharing class rerendercheckCon {
    public String selected{get;set;}
    public boolean isPoller{get;set;}
    public string result{get;set;}
    
    public rerendercheckCon(){
    result='Hello Testing constructor';
    }
    public void dosome(){
        isPoller=true;
        selected='yes';
        
    }
    public pagereference pollerMethod(){
        isPoller=false;
        selected='no';
        return null;
    }
}