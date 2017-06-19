public with sharing class DupSearchController {

public List<Account> accList{get;set;}
public List<Contact> contList{get;set;}
public List<Lead> leadList{get;set;}
public string searchStr{get;set;}
public  string fname{get;set;}
public  string lname{get;set;}
public  string email{get;set;}
public  string company{get;set;}
public  string phone{get;set;}
public  string domain{get;set;}
public Integer lcount{get;set;}
public Integer acount{get;set;}
public Integer ccount{get;set;}
public string searchFields{get;set;}
public string qtext{get;set;}
public static boolean mainSearchFlag=true;


public DupSearchController(){
fname=ApexPages.currentPage().getParameters().get('FirstName')=='$'? null : ApexPages.currentPage().getParameters().get('FirstName');
lname=ApexPages.currentPage().getParameters().get('LastName')=='$'? null : ApexPages.currentPage().getParameters().get('LastName');
email=ApexPages.currentPage().getParameters().get('EMail')=='$'? null : ApexPages.currentPage().getParameters().get('EMail');
phone=ApexPages.currentPage().getParameters().get('Phone')=='$'? null : ApexPages.currentPage().getParameters().get('Phone');
company=ApexPages.currentPage().getParameters().get('Company')=='$'? null : ApexPages.currentPage().getParameters().get('Company');
domain=ApexPages.currentPage().getParameters().get('Domain')=='$'? null : ApexPages.currentPage().getParameters().get('Domain');
system.debug('WHat is the value--'+fname+'...'+lname);
mainSearchFlag=false;
getSearch();

}
public void getSearch(){
accList=new List<Account>();
contList=new List<Contact>();
leadList=new List<Lead>();

//searchStr='*'+fname+' AND '+lname+'*';

system.debug('Inside is the value--'+fname+'...'+lname);
if(fname!=''){
searchStr=fname;        
}

if(lname!=''){
   searchStr=searchStr+'_'+lname;
}

if(company!=''){
        searchStr=searchStr+'_'+company;
}
if(email!=''){
searchStr=searchStr+'_'+email;  
}
if(phone!=''){
searchStr=searchStr+'_'+phone;  
}
if(domain!=''){
searchStr=searchStr+'_'+domain; 
}

system.debug('Search--'+searchStr);
if(searchStr.contains('_')){
searchFields=searchStr.replaceAll('_',' AND ');
}else{
    searchFields=searchStr;
}
  //  if(searchFields.length()>0){
 //String searchQuery='Find {"Rajesh Thumu" OR "Rajesh Th"} IN ALL FIELDS RETURNING ACCOUNT(Id,Name,State__c,Country__c,phone,type,Industry),Contact(Id,Name,Email,Title,Phone,AccountID),Lead(Id,Name,Email,Title,phone,Company,Status)';
  String searchQuery='FIND\''+searchFields+'\'IN ALL FIELDS RETURNING ACCOUNT(Id,Name,phone,type,Industry),Contact(Id,Name,Email,Title,Phone,AccountID),Lead(Id,Name,Email,Title,phone,Company,Status)';
  system.debug('Search--'+searchQuery);
    List<List<sObject>> searchList=search.query(searchQuery);
  system.debug('count-'+ searchList[0].size()+ searchList[1].size()+searchList[2].size());
  lcount=searchList[2].size();
  ccount=searchList[1].size();
  acount=searchList[0].size();
      accList=((List<Account>)searchList[0]);
     contList=((List<Contact>)searchList[1]);
     leadList=((List<Lead>)searchList[2]);
        
 //   }

 }
 public void refresh() {
    accList.clear();
    contList.clear();  
    leadList.clear(); 
    lcount=0;
    ccount=0;
    acount=0;
    fname='';
     lname='';
      email='';
     company='';
     phone='';
     domain='';
     searchStr='';
     searchFields='';
     
    }
}