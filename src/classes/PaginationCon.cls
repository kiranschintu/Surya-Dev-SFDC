public with sharing class PaginationCon {

    public List<Account> Pagenationlist {get;set;}
    public String strstatus{get;set;}
    public String strlabelname {get;set;}
    public Id strUserId{get;set;}
    public List<Id> myIds{get;set;}
    public List<SelectOption> lstdisplay{get;set;}

    public ApexPages.StandardSetController Con{get; set;} 
 
    public Integer pageNumber;//used for pagination
    public Integer pageSize;//used for pagination
    public Integer totalPageNumber;//used for pagination
    public Integer PrevPageNumber {get;set;}//used for pagination
    public Integer NxtPageNumber {get;set;}//used for pagination
    public Integer NlistSize {get;set;}//used for pagination
    public Integer Endlst {get;set;}//used for pagination
    public integer totallistsize{get;set;}//total size of list SPFolderset and SPWFilesList for pagination
   
    public PaginationCon(){
        // Get the Current Page Name
        pageNumber = 0;
        totalPageNumber = 0;
        pageSize = 25;

        //To fill the User Picklist
        List<User> objusers = new List<User>();
        lstdisplay = new List<SelectOption>();
        objusers = [SELECT Id,Username,Name FROM User 
                     WHERE IsActive=True order by Name
                     ];
        
        for(User obj : objusers){
            lstdisplay.add(new SelectOption(obj.Id,obj.Name));  
        }     
        createTheList();
    }
    
    public void createTheList(){
        system.debug('----strstatus--'+strstatus);
        
        String Query = 'Select id,Name from Account ';
     
        if(String.valueOf(strUserId) != null && String.valueOf(strUserId) != ''){
            Query += ' WHERE OwnerId =\''+strUserId+'\' ';
        }
        
        Query += ' order by Name DESC';
     
        system.debug('-------Query----'+Query);
     
        //storing all requests ids into myIds
        myIds = new List<Id>();
        for(Account req:Database.query(Query)){
            myIds.add(req.id);
        }
        
        totallistsize = myIds.size();
        
        system.debug('totallistsize'+totallistsize);
        
        if(totallistsize==0){
            Pagenationlist = new List<Account>();
            NxtPageNumber=Pagenationlist.size();
            PrevPageNumber=0;
            ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.INFO,'No Requests Found');
            ApexPages.addMessage(errormsg);
        }
        else{
            BindData(1);// this method is for pagination, if atleast one record found then passing 1 to the pagination method
            NxtPageNumber=Pagenationlist.size();
            PrevPageNumber=1;
            
        }
     }  
    
    public Integer getPageNumber(){
        return pageNumber; 
    }
    
    public Integer getPageSize(){
        return pageSize;
    }

    public Boolean getPreviousButtonEnabled(){
        return !(pageNumber > 1);
    }

    public Boolean getNextButtonDisabled(){
        if (totallistsize ==0) 
            return true;
        else
            return ((pageNumber * pageSize) >= totallistsize);
    }

    public Integer getTotalPageNumber(){
        totalPageNumber=0;
        if (totalPageNumber == 0 && totallistsize!=0){
            totalPageNumber = totallistsize / pageSize;
            Integer mod = totallistsize - (totalPageNumber * pageSize);
            if (mod > 0){
                totalPageNumber++;
            }
        }

        return totalPageNumber;
    }
    
    public void BindData(Integer newPageIndex){
        try{
            Pagenationlist = new List<Account>();
            Transient Integer counter = 0;
            Transient Integer min = 0;
            Transient Integer max = 0;
            
            List<User> allUsers = new List<User>([Select id, Name from User where isActive=true]);
            Map<Id, String> mapAllUsers = new Map<Id, String>();
            //add Users to maps with key as email address
            for(User tempUser : allUsers){
                mapAllUsers.put(tempUser.Id, tempUser.Name);
            }
            
            if(pageSize == null){
                pageSize =25;
            }
            
            if (newPageIndex > pageNumber){
                min = pageNumber * pageSize;
                max = newPageIndex * pageSize;
            }
            else{
                max = newPageIndex * pageSize;
                min = max - pageSize;
            }
           
           Set<Id> pageIds = new Set<Id>();
           for(Id reqId : myIds){
                counter++;
                if (counter > min && counter <= max){
                    pageIds.add(reqId);
                }
                if(pageIds.size()==25){
                    break;
                }
           }
           String query = buildPageRecsQuery();
           
           for(Account req : DataBase.query(query)){
                
                Pagenationlist.add(req);// here adding the folders list      
           }
            pageNumber = newPageIndex;
            NlistSize=Pagenationlist.size();
        }
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
        }
    }


    public void pageNumbers(Integer newPageIndex){
        if (newPageIndex > pageNumber){                                              
            PrevPageNumber=PrevPageNumber+pagesize;   
            NxtPageNumber=NxtPageNumber+NlistSize; 
        }
        if (newPageIndex < pageNumber){                                 
                PrevPageNumber=PrevPageNumber-pagesize;               
                NxtPageNumber=NxtPageNumber-NlistSize;                   
        }
    }
    
    public void LastpageData(integer newPageIndex)
    {
        try{
            Pagenationlist = new List<Account>();
            Transient Integer counter = 0;
            Transient Integer min = 0;
            Transient Integer max = 0;      
            
            min = newPageIndex * pageSize;
            max = totallistsize;    
            
           Set<Id> pageIds = new Set<Id>();
           for(Id reqId : myIds){
                counter++;
                if (counter > min && counter <= max){
                    pageIds.add(reqId);
                }
           }
           counter=0;
           String query = buildPageRecsQuery();
           for(Account req : Database.Query(query)){
                Pagenationlist.add(req);// here adding the folders list      
            }
            
            pageNumber = newPageIndex;
            NlistSize=Pagenationlist.size();
             
            PrevPageNumber=totallistsize - NlistSize +1;   
            NxtPageNumber=totallistsize;
            pageNumber +=1;
        }
        catch(Exception ex){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
        }
        
    }
    
    public PageReference nextBtnClick(){
        BindData(pageNumber + 1);
        pageNumbers(pageNumber + 1);
        return null;
    }

    public PageReference previousBtnClick(){
        pageNumbers(pageNumber - 1);
        BindData(pageNumber - 1);
        return null;
    }
    
    public PageReference LastbtnClick(){
        LastpageData(TotalPageNumber-1);
        return null;
    }
    
    public PageReference FirstbtnClick(){
        BindData(1);// this method is for pagination, if atleast one record found then passing 1 to the pagination method
        NxtPageNumber=NlistSize;
        PrevPageNumber=1;
        return null;
    }
    
    public string buildPageRecsQuery(){
        String query = 'SELECT id,name,phone,CreatedDate  FROM Account where Id in:pageIds order by Name DESC';
        return query;
    } 
}