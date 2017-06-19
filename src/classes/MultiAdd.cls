public class MultiAdd
{
    
    //will hold the account records to be saved
    public List<Account>lstAcct  = new List<Account>();
    
    //list of the inner class
    public List<innerClass> lstInner{get;set;}
    
    //will indicate the row to be deleted
    public String selectedRowIndex{get;set;}  
    
    //no. of rows added/records in the inner class list
    public Integer count = 1;
    public Account acct;
    
    
    
    ////save the records by adding the elements in the inner class list to lstAcct,return to the same page
    public PageReference Save()
    {
        //PageReference pr = new PageReference('/apex/sucess');
        acct = new Account();
        for(Integer j = 0;j<lstInner.size();j++)
        {
            lstAcct.add(lstInner[j].acct);
        } 
        try{
        insert lstAcct;
       
        }catch(DMLException ex){}
        for(Account an:lstAcct ){
       if(an.Active__c=='No'){
       return null;}
        }
        return (new pagereference('/apex/sucess'));
        }
        
    //add one more row
    public void Add()
    {   
        count = count+1;
        addMore();      
    }
    
    /*Begin addMore*/
    public void addMore()
    {
        //call to the iner class constructor
        innerClass objInnerClass = new innerClass(count,acct);
        
        //add the record to the inner class list
        lstInner.add(objInnerClass);    
        system.debug('lstInner---->'+lstInner);            
    }/* end addMore*/
    
    /* begin delete */
    public void Del()
    {
        system.debug('selected row index---->'+selectedRowIndex);
        lstInner.remove(Integer.valueOf(selectedRowIndex)-1);
        count = count - 1;
        
    }/*End del*/
    
    
    
    /*Constructor*/
    public MultiAdd(ApexPages.StandardController ctlr)
    {
    
        lstInner = new List<innerClass>();
        addMore();
        selectedRowIndex = '0';
        
    }/*End Constructor*/
        


    /*Inner Class*/
    public class innerClass
    {       
        /*recCount acts as a index for a row. This will be helpful to identify the row to be deleted */
        public String recCount{get;set;}
        
        
        public Account acct{get;set;}
        
        /*Inner Class Constructor*/
        public innerClass(Integer intCount,Account acct)
        {
            recCount = String.valueOf(intCount);        
            
            /*create a new account*/
            this.acct = acct;
            
        }/*End Inner class Constructor*/    
    }/*End inner Class*/
}/*End Class*/