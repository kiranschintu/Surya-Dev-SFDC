public with sharing class mytransient {
    DateTime NoTranTime;
     Transient DateTime TranTime;
    public string s{get;set;}
    
    
    
    public String getTranTime(){
        
        if(TranTime==Null)
        s='hello';
        TranTime = system.now();
        return ''+TranTime;
    }public String getNoTranTime(){
        
        if(NoTranTime==Null)
        NoTranTime = system.now();
        s='hi';
        return ''+NoTranTime;
    }
}