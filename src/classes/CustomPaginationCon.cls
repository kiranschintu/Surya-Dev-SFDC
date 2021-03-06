public with sharing class CustomPaginationCon {
    public List<Account> accounts{get;set;}
    public List<Account> copyAccounts{get;set;}
    
    /***
    pagination
    ***/
    public Integer PrevPageNumber {get;set;}//used for pagination
    public Integer NxtPageNumber {get;set;}//used for pagination
    public integer totallistsize{get;set;}//used for pagination
    public integer counter=0;  //keeps track of the offset
    public Integer NlistSize {get;set;}//used for pagination
    public Integer pageNumber;//used for pagination
    public Integer totalPageNumber;//used for pagination
    public integer pageSize=5; //sets the page size or number of rows
    public integer total_size{get;set;}//for pagination
    
    
    
    
    
    public CustomPaginationCon() {
        accounts = [select id,name from Account order by name];
        totallistsize=accounts.size();
               if(totallistsize==0)
                {
                    BindData(0);// this method is for pagination, if no records found then passing zero to the pagination method
                    NxtPageNumber= copyAccounts.size();
                    PrevPageNumber=0;
                }
                else
                {
                    BindData(1);// this method is for pagination, if atleast one record found then passing 1 to the pagination method
                    NxtPageNumber= copyAccounts.size();
                    PrevPageNumber=1;
                }  
    }
    
    
    /**************
    Pagination
    *************/
    
    public PageReference FirstbtnClick() { //user clicked beginning
         
        BindData(1);// this method is for pagination, if atleast one record found then passing 1 to the pagination method
        NxtPageNumber=NlistSize;
        system.debug('NxtPageNumber================'+NxtPageNumber);
        PrevPageNumber=1;
        return null;
    }
    
    public PageReference previousBtnClick() { //user clicked previous button
          pageData(pageNumber - 1);
          BindData(pageNumber - 1);
          return null;
    }
    
    public PageReference nextBtnClick() { //user clicked next button
        system.debug(NxtPageNumber+'nextbutton'+pageNumber);
        BindData(pageNumber + 1);
        pageData(pageNumber + 1);
        return null;
    }
    
    public PageReference LastbtnClick() { //user clicked end
        BindData(totalpagenumber - 1);
        system.debug('Lastbutton++'+pagenumber);
        LastpageData(totalpagenumber);
        //pagenation();
        return null;
    }
    
    public Boolean getPreviousButtonEnabled() {
        //this will disable the previous and beginning buttons
        return !(pageNumber > 1);
    }
    
    public Boolean getNextButtonDisabled() { //this will disable the next and end buttons
        if (totallistsize ==0) 
            return true;
        else
            system.debug('totallistsize**************'+totallistsize);   
        return ((pageNumber * pageSize) >= totallistsize);      
    }
    
    public Integer getPageSize() {
        system.debug('pageSize********pageSize******'+pageSize);
        return pageSize;
    }
    
    public Integer getPageNumber() {
        system.debug('pageNumber********pageNumber******'+pageNumber);
        return pageNumber; 
    }
    
    public Integer getTotalPageNumber() {
        totalPageNumber = 0;
        if (totalPageNumber == 0 && totallistsize!=0)
        {
            system.debug(totalPageNumber+'-totallistsize--'+totallistsize);
            totalPageNumber = totallistsize / pageSize;
            Integer mod = totallistsize - (totalPageNumber * pageSize);
            if (mod > 0)
                totalPageNumber++;
                system.debug('totalPageNumber********pageNumber******'+totalPageNumber);
        }
        return totalPageNumber;
    } 
    
    public void BindData(Integer newPageIndex)
    {
        try
        {
            copyAccounts = new List<Account>();
            Transient Integer counter = 0;
            Transient Integer min = 0;
            Transient Integer max = 0;
            
            if(pageSize == null)pageSize = 50;
            if (newPageIndex > pageNumber)
            {
                min = pageNumber * pageSize;
                max = newPageIndex * pageSize;
            }
            else
            {
                max = newPageIndex * pageSize;
                min = max - pageSize;
            }
            if(!accounts.isEmpty())
            {
                for(Account b : accounts)
                {
                    counter++;
                    if (counter > min && counter <= max) 
                    {
                        //b.error=true;
                        copyAccounts.add(b);// here adding files list
                    }
                }
            }
            pageNumber = newPageIndex;
            NlistSize = copyAccounts.size();
        }
        catch(Exception ex)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
        }
    }
    
    public void pageData(Integer newPageIndex)
    {   
        if (newPageIndex > pageNumber)
        {
            PrevPageNumber=PrevPageNumber+pagesize;   
            NxtPageNumber=NxtPageNumber+NlistSize; 
        }
        if (newPageIndex < pageNumber)               
        {                                 
            PrevPageNumber=PrevPageNumber-pagesize;               
            NxtPageNumber=NxtPageNumber-NlistSize;      
             
        }
        system.debug('NlistSize============='+NlistSize);
    }
    public void LastpageData(Integer newPageIndex)
    {
        try
        {
            copyAccounts = new list<Account>();
            Transient Integer counter = 0;
            Transient Integer min = 0;
            Transient Integer max = 0;          
            system.debug('NlistSizeLastpage1============='+NlistSize);
            min = pageNumber * pageSize;
            max = newPageIndex * pageSize;    
            
            if(!accounts.isEmpty())
            {
                for(Account b : accounts)
                {
                    counter++;
                    if (counter > min && counter <= max) 
                    {
                        copyAccounts.add(b);// here adding files list
                    }
                }
            }
            pageNumber = newPageIndex;
            NlistSize=copyAccounts.size();
                
            PrevPageNumber=totallistsize - NlistSize +1;   
            NxtPageNumber=totallistsize;
        }
        catch(Exception ex)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
        }
    }
    
    
    
    
}