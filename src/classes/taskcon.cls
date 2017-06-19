public class taskcon {
    
    
    public List<Task> searchResults {get;set;}
    public string searchText {get;set;}
    public List<Task> taklist1;
    public Integer Count;
    public Task t1{get;set;}
    public Task t2{get;set;}
          
    public taskcon(ApexPages.StandardController controller) {
         t1 = new Task();
         t2 = new Task();
    }
    public List<Task> getRecordss(){
        
        taklist1 = [select id,subject,Priority,Status,description,ActivityDate from Task];
        Count = taklist1.size();
        return taklist1;
    }    
        
    public Integer getCounts(){
        return Count;
    }
    public PageReference search() {
    
        if(t1.Status!=null & t1.Priority==null){
          searchResults = [SELECT Id,subject,priority,status,ActivityDate from Task  where Status =:(t1.Status)];
          }
        /* if(t1.priority!=null&t1.Status==null){
            searchResults = [SELECT Id,subject,priority,status,ActivityDate from Task  where Priority =:(t1.Priority)];// AND ActivityDate >=:(t1.ActivityDate) AND ActivityDate <=:(t2.ActivityDate)
        }
       else if (t1.priority!=null&t1.status!=null){
            searchResults = [SELECT Id,subject,priority,status from Task  where status =:(t1.status) AND priority =:(t1.priority)];
        }*/
    
    return null;
  }
  
  public List<SelectOption> getPriorities(){

        List<SelectOption> Priority = new List<SelectOption>();
        Priority.add(new SelectOption('','fdfdf'));
        Schema.DescribeFieldResult fieldResult = Task.Priority.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            Priority.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return Priority;
    }
    
    public List<SelectOption> getStatuses(){

        List<SelectOption> Status = new List<SelectOption>();
        Status.add(new SelectOption('','--None--'));
        Schema.DescribeFieldResult fieldResult = Task.Status.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            Status.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return Status;
    }

  
  
  public PageReference Cancel() {
      //PageReference newOpp = new PageReference('/home/home.jsp');
      //return newOpp;
      ApexPages.Message Msg = new ApexPages.Message(ApexPages.severity.Info, 'Check ' + t1.Status+' '+t1.Priority+' ' +t1.ActivityDate);
             ApexPages.addMessage(Msg);
             return null;
      
     }
   
}