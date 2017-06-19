public with sharing class Pagination {
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}
    public List<Account> processdList{get;set;}
    List<Account> accountsLst;//access across the class
    Map<Integer,List<Account>> accountsMap{get;set;}//to maintain modified records acorss the navigation
    
    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 5;
                string queryString = 'Select Name, Type, BillingCity, BillingState, BillingCountry from Account where name like\'Custom%\' order by Name limit 20';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }
    public Pagination(){
        List<Account> accList = new List<Account>();
        accountsMap = new Map<Integer,List<Account>>();
        processdList = new List<Account>();
    }
    Public List<Account> getAccounts(){
        List<Account> accList = new List<Account>();
        
        system.debug('Page Number>>'+pageNumber);
        accountsLst = new List<Account>();
        
        for(Account a : (List<Account>)setCon.getRecords()){
            accList.add(a);
         }
         system.debug('accList<<'+accountsLst.size());
         accountsLst = accList.deepClone(true, true, true) ;//to edit records in standard set controller
         //to maintain modified records acorss the navigation
         if(accountsMap.containskey(pageNumber) && accountsMap.get(pageNumber).size()>0){
            accountsLst = accountsMap.get(pageNumber);
         }
         return accountsLst;
    }
     
    public void pushModifiedRecordsToMap(){
        processdList = new List<Account>();
        accountsMap.put(pageNumber,accountsLst);
        for(Integer cn:accountsMap.keySet()){
            processdList.addAll(accountsMap.get(cn));
        }
        system.debug('map size>>'+accountsMap.size());
        system.debug('map>>'+accountsMap);
        system.debug('processdList>>'+processdList);
    }
     
    public Boolean hasNext{
        get{
            return setCon.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious{
        get{
            return setCon.getHasPrevious();
        }
        set;
    }
  
    public Integer pageNumber{
        get{
            return setCon.getPageNumber();
        }
        set;
    }
  
    public void first(){
        pushModifiedRecordsToMap();
        setCon.first();
    }
  
    public void last(){
        pushModifiedRecordsToMap();
        setCon.last();
    }
  
    public void previous(){
        pushModifiedRecordsToMap();
        setCon.previous();
    }
  
    public void next(){
        pushModifiedRecordsToMap();
        setCon.next();
    }
}