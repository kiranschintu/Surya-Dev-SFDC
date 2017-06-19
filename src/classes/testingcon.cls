@isTest
public class testingcon{
    private static testMethod void test1(){
     
         //List<Task> con = new List<Task>();
        //con.add(new Task(Type='SMS',Status = 'Completed',ActivityDate = System.today(),Description = 'sdfsd',Subject = 'SMS Sent'));
        Task con = new Task(Type='SMS',Status = 'Completed',ActivityDate = System.today(),Description = 'sdfsd',Subject = 'SMS Sent');
        insert con; 
       ApexPages.StandardController controller = new ApexPages.StandardController(con);
       taskcon t1 = new taskcon(controller);
       t1.getRecordss(); 
       t1.getCounts(); 
       t1.search();
       t1.cancel(); 
       t1.getPriorities();
       t1.getStatuses();   
     }
  
}