global with sharing class TermsAndConditions{
    public boolean termsandConditions{get;set;}
    public list<Document> lstD{get;set;}
    public string BsureLogo{get;set;}
    public string strqueryParam{get;set;}
    public string DocName{get;set;} 
    public String strBSure{get;set;}
    public TermsAndConditions(){
      DocName = 'Logo';
      strBSure = 'BSure';
        lstD =  new list<Document>();
        // Checking Query Permession and avoiding soql injection
        if(Schema.Sobjecttype.Document.isQueryable())
          lstD = [select Id,Name from Document where Name=:DocName limit 1];
        strqueryParam = Apexpages.currentPage().getParameters().get('startURL');
        if(!lstD.isEmpty())
            BsureLogo = '/servlet/servlet.FileDownload?file='+lstD[0].Id;
    }
    
    public PageReference  logoutmethod(){
      String host1 = ApexPages.currentPage().getHeaders().get('Host');
      String url = 'https://'+host1+'/secur/logout.jsp';
      PageReference p = new PageReference(url);
      p.setRedirect(true);
      return p;
    }
    
    public PageReference  Accept(){
      PageReference ref;
      
      if(strqueryParam != null && strqueryParam != '')
      {
        if(strqueryParam.contains(strBSure))
        {
          ref = new PageReference(strqueryParam);
        }  
      }
      else
      {
        ref = new PageReference('/home/home.jsp?loginFlag=false');  
      }
      ref.setRedirect(true);
        return ref ;
    }
}