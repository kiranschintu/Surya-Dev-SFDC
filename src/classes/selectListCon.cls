public class selectListCon {
    
    public List<Task> searchResults {get;set;}
    public string searchText {get;set;}
           
    Task t1 = new Task();
    public Task getTask(){
        return t1;
    }
    
    public void setTask(Task temp){
    t1 = temp;
    }
       
    public selectListCon(ApexPages.StandardController controller) {
    
    }
        
    
    public PageReference search() {
          searchResults = [SELECT Id,subject,priority,status from Task  where priority =:(t1.priority)];
          return null;
  }
  
  public List<SelectOption> getPriorities()
    {
        List<SelectOption> Priority = new List<SelectOption>();
        Priority.add(new SelectOption('','--None--'));
        Schema.DescribeFieldResult fieldResult = Task.Priority.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            Priority.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return Priority;
    }
  
  
  public PageReference Cancel() {
      PageReference newOpp = new PageReference('/home/home.jsp');
      return newOpp;
  }
       
}