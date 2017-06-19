public with sharing class WrapperSortingCOn {
    
    public List<WrapperAccount> wrappers{get;set;}
    public List<WrapperAccount> copyWrappers{get;set;}
    public boolean rowstate{get;set;}
    //private String sortDirection = 'ASC';
    //private String sortExp = 'name';
    public String sortExpression{get;set;}
    public String sortDirection{get;set;}
    public Boolean nxtbtn{get;set;}
    public Boolean prvbtn{get;set;}
    public Boolean lstbtn{get;set;}
    public Boolean fstbtn{get;set;}
    
    public void ViewData(){
        string sortFullExp = sortExpression  + ' ' + sortDirection;
        system.debug('sortDirection$$$'+sortDirection);
        If(sortDirection== 'ASC'){
            //sortDirection='DESC';
            Last10Records();
           
        }else{
            sortDirection= 'ASC';
             First10Records();
        }
       
    }
    
    public WrapperSortingCOn () {
        copyWrappers = new List<WrapperAccount>();
        First10Records();
    }
    
    public void First10Records(){
        retriverecs('ASC');
        fstbtn=true;
        lstbtn=false;
        prvbtn=true;
        nxtbtn=false;
        copyWrappers = new List<WrapperAccount>();
        if(wrappers.size()>10){
            for(Integer i=0; i<10 ;i++){
                copyWrappers.add(wrappers[i]);
            }
        }
    }
    
    public void Last10Records(){
        
        
        copyWrappers = new List<WrapperAccount>();
        
        if(sortDirection=='DESC'){
            retriverecs('DESC');
            lstbtn=false;
            fstbtn=true;
            prvbtn=true;
            nxtbtn=false;
            
            if(wrappers.size()>10 ){
            system.debug('In if condition');
            //for(Integer i = 0; i<10 ;i++){
            for(Integer i = wrappers.size()-1;i>wrappers.size()-10;i--){
                system.debug('Record ::'+wrappers[i]);
                copyWrappers.add(wrappers[i]);
            }
        }
        }else{
            retriverecs('ASC');
            lstbtn=true;
            fstbtn=false;
            prvbtn=false;
            nxtbtn=true;
            
            if(wrappers.size()>10 ){
            system.debug('In if condition');
            for(Integer i = wrappers.size()-10; i<wrappers.size() ;i++){
                system.debug('Record ::'+wrappers[i]);
                copyWrappers.add(wrappers[i]);
            }
        }
        }
        
        
        system.debug('Records::'+wrappers);
        system.debug('Records size::'+wrappers.size());
        system.debug('First Record'+wrappers[0]);
        
        system.debug('Copy Records::'+copyWrappers);
    }
    
    public void next(){
        system.debug('Record is&&&'+copyWrappers);
        Integer prevRecord;
        Integer Size;
        prvbtn=false;
        fstbtn=false;
                
        if(sortDirection=='ASC'){
            prevRecord = copyWrappers[copyWrappers.size()-1].acc.Account_Number__c.intValue()+1 ;
            Size = prevRecord+10;
        }
        else{
            prevRecord = copyWrappers[copyWrappers.size()-1].acc.Account_Number__c.intValue() ;
            prevRecord = wrappers.size() - prevRecord;
            Size = prevRecord+10;
        }
        
        copyWrappers = new List<WrapperAccount>();
        system.debug('Records::'+wrappers);
        system.debug('Records size::'+wrappers.size());
        system.debug('prevRecord::'+prevRecord );
        system.debug('Size::'+Size );
                
        if(wrappers.size()>10 && wrappers.size()!=prevRecord ){
            system.debug('In if condition');
            for(Integer i = prevRecord; i<Size ;i++){
                system.debug('Record ::'+wrappers[i]);
                copyWrappers.add(wrappers[i]);
            }
        }
        
        if(wrappers.size()==prevRecord+10){
            nxtbtn=true;
            lstbtn=true;
        }
    }
    
    public void previous(){
        system.debug('Record is&&&'+copyWrappers);
        Integer prevRecord;
        Integer prevRecCount;
        Integer Size;
        nxtbtn = false;
                
        if(sortDirection=='ASC'){
            prevRecord = copyWrappers[0].acc.Account_Number__c.intValue()-10 ;
            prevRecCount = prevRecord;
            Size = prevRecord+10;
        }
        else{
            prevRecord = copyWrappers[copyWrappers.size()-1].acc.Account_Number__c.intValue() ;
            prevRecCount = prevRecord;
            prevRecord = wrappers.size() - prevRecord;
            Size = prevRecord+10;
        }
        
        copyWrappers = new List<WrapperAccount>();
        system.debug('Records::'+wrappers);
        system.debug('Records size::'+wrappers.size());
        system.debug('prevRecord::'+prevRecord );
        system.debug('Size::'+Size );
        system.debug('Record is***'+wrappers);
        if(wrappers.size()>10 && prevRecord+10 !=0){
            system.debug('In if condition');
            for(Integer i = prevRecord; i<Size ;i++){
                system.debug('Record ::'+wrappers[i]);
                copyWrappers.add(wrappers[i]);
            }
        }
        
        if(prevRecord==0){
            prvbtn=true;
        }
    }
    
     
    public void retriverecs(String sortord){
        wrappers = new List<WrapperAccount>();
        sortDirection= sortord;
        sortExpression = 'AccountNumber';
        Integer s;
        Integer s1;
        if(sortDirection=='ASC'){
            s=1;
            s1=-1;
        }else{
            s=-1;
            s1=1;
        }
        
        
        for(Account acc : [select id,name,phone,Account_Number__c from Account where Account_Number__c!=null AND Account_Number__c<60  limit 100]){
            wrappers.add(new WrapperAccount(acc,s,s1));
        }
       wrappers.sort();   
       system.debug('Wrappers%%%'+wrappers);  
    }
     
    public class WrapperAccount implements Comparable{
        public Account acc{get;set;}
        public Integer status{get;set;}
        public Integer status1{get;set;}
        public WrapperAccount(Account acc,Integer status,Integer status1){
            this.acc = acc;
            this.status = status;
            this.status1 = status1;
        }
        
        //Integer st=1;
        //Integer st1=-1;
        //Sorting wrapper list based on csv column number
            public Integer compareTo(Object ObjToCompare) {
                
                WrapperAccount compareToPhone = (WrapperAccount)ObjToCompare;
                // The return value of 0 indicates that both elements are equal. 
                Integer returnValue = 0;
                if (acc.Account_Number__c> compareToPhone.acc.Account_Number__c){
                    // Set return value to a positive value. 
                    returnValue = status ;
                }
                else if (acc.Account_Number__c< compareToPhone.acc.Account_Number__c){
                    // Set return value to a negative value. 
                    returnValue = status1 ;
                }
                return returnValue;  
            }
    }
}