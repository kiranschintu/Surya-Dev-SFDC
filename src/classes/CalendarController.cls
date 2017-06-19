/**
    Author : Vijay Selvaganapathy
    Company: Vertex Computer Systems
    Description: This controller provides the business logic to display the scheduler calendar view.
**/
public class CalendarController {

    // Declare public variables and properties here
    
     
    public list<calEvent> events {get;set;}
    public String schNames {get;set;}    
    public News__c sch {get;set;}         
    
    public String dayStr;
    
    String strTemp;
    
    //The calendar plugin is expecting dates is a certain format. We can use this string to get it formated correctly

     String dtFormat = 'EEE, d MMM yyyy HH:mm:ss z';
     String key; 
     Set<String> strIDs;
     Map<String,News__c> mapSchedule;  
     Map<Date,String> mapSchDate; 
     Map<Id,User> mapUser;      
     Map<String,String> mapDays = new Map<String,String>{'Mon'=>'Monday','Tue'=>'Tuesday','Wed'=>'Wednesday','Thu'=>'Thursday','Fri'=>
     'Friday','Sat'=>'Saturday','Sun'=>'Sunday'};  

    //constructor

    public CalendarController() {

        // Initialize variables here
       
        // Pull users from Scheduler object and create a map
        List<News__c> lstSchedule = new List<News__c>([select Name, User__r.Name,SchedulerDate__c from News__c]);         
        mapSchedule = new Map<String, News__c>();
        mapSchDate = new Map<Date,String>();
        for(News__c tmpSchedule : lstSchedule) {
          if(tmpSchedule.Name !=null && tmpSchedule.Name !='' && tmpSchedule.SchedulerDate__c !=null) 
          key = tmpSchedule.Name+'-'+tmpSchedule.SchedulerDate__c;
          else if(tmpSchedule.Name !=null && tmpSchedule.Name !='' && tmpSchedule.SchedulerDate__c == null)
          key = tmpSchedule.Name;
          System.Debug('key constr = '+key);
          if(!mapSchedule.containsKey(key))           
            mapSchedule.put(key, tmpSchedule);
        }     
                
        // The request parameters are passed to the popup window so that the user name is selected in the pick list
        dayStr = ApexPages.CurrentPage().getParameters().get('start'); 
        schNames = ApexPages.CurrentPage().getParameters().get('name'); 
        
        System.Debug('schnames = '+schNames +' dayStr = '+dayStr);
        if(schNames !=null && schNames != '' && dayStr !=null && dayStr !='') {
           String dtStr = ApexPages.CurrentPage().getParameters().get('dt'); 
           Date dt ;
          
             try {
                dt = Date.parse(dtStr);
               }catch(Exception ex) {
                  dt = null;
                  sch = [select User__r.Name,Name,User__c from News__c where User__r.Name = :schNames and Name = :dayStr and SchedulerDate__c = null LIMIT 1 ];
                  System.Debug(LoggingLevel.WARN,'sch in catch = '+sch);
               }
          try {     
            if(dt !=null) sch = [select User__r.Name,Name,User__c from News__c where User__r.Name = :schNames and Name = :dayStr and SchedulerDate__c = :dt LIMIT 1 ];
            System.Debug('sch = '+sch);
           }catch(QueryException qe) {           
            sch = null;     
           } 
           catch(Exception ex) {
             System.Debug(LoggingLevel.WARN,'In exception = '+ex.getMessage());
              Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));  
           }
        } 
           

    }
  
     // This method pre-populates the calendar with the user names based on the scheduler configuration. The details are populated till 2 years from the current date.
    public PageReference pageLoad() {

        events = new list<calEvent>();   // Instantiate new event list to hold new events. Events in this case is the user names     
     
        DateTime Ed = DateTime.Now().addMonths(3);  // This will populate the calendar with user names upto 2 years. This is the recommended limit.    
         
        System.Debug('Ed = '+Ed);
        
        // Iterate each day and add the user name belonging to that date based on scheduler configuration
        for(DateTime sd =  DateTime.now(); sd <= ed; sd.addDays(1) ){

             
            DateTime startDT = datetime.newInstance(sd.Year(),sd.Month(), sd.Day());

            calEvent evt = new calEvent();           

                   
            
            key = mapDays.get(sd.format('E'))+'-'+sd.date();
            
            News__c schTemp  = mapSchedule.get(key);     
            
           // System.Debug('key in pageLoad = '+key);                            
             
             if(schTemp !=null) evt.title = schTemp.User__r.Name;
             else if(schTemp == null) {
                schTemp = mapSchedule.get(mapDays.get(sd.format('E')));
                evt.Title = schTemp !=null ? schTemp.User__r.Name: '';
               // System.Debug('format = '+sd.format('E')+' '+ SchedulerTracker__c.getInstance(sd.format('E')));
                if(evt.Title == '') evt.Title = SchedulerTracker__c.getInstance(mapDays.get(sd.format('E')))!= null ? SchedulerTracker__c.getInstance(mapDays.get(sd.format('E'))).UserName__c : '';
             }
             
           // evt.title = schTemp !=null  ? schTemp.User__r.Name : mapSchedule.get(mapDays.get(sd.format('E'))) ;          , 
            

            evt.allDay = true; 

            evt.startString = startDT.format(dtFormat);

            //Because this is an all day event that only spans one day, we can leave the send date null

            evt.endString = '';

            evt.url = '/apex/SchdPopup?name='+evt.title+'&start='+mapDays.get(sd.format('E'))+'&dt='+sd.format('MM/dd/yyyy'); // Popup window where the user can change and update the assigned user for that day 

            //evt.className = 'event-birthday';

            events.add(evt);
            
            sd = sd.addDays(1);

        }         

        return null;

    }  

   
    // This method provides data for the picklist
    public List<selectOption> getNames() {
  //   List<AggregateResult> schList = [select User__r.Name UserName from News__c group by User__r.Name order by User__r.Name ];
        List<AggregateResult> schList = [select Name UserName from User where isActive = true group by Name order by Name ];  
        List<SelectOption> options = new List<SelectOption>();
        for(AggregateResult sch :schList)
        options.add(new SelectOption((String)sch.get('UserName'),(String)sch.get('UserName')));  
        return options;
    }
    
    // This method updates the scheduler object with the name and user id selected by the user.
    public PageReference updateScheduler() {
       
         //News__c sch;
         String dayStr = ApexPages.CurrentPage().getParameters().get('start'); 
         String dtStr = ApexPages.CurrentPage().getParameters().get('dt'); 
         Date dt = Date.parse(dtStr);
         System.Debug('in update = '+sch+' '+schNames);
         //Added logic to query IsActive=True July 22nd
         User usr = [select id from User where Name = :schNames AND IsActive=True limit 1];
         SchedulerTracker__c st;
         try {
             if(sch!=null) {
                sch.Name = dayStr;  
                sch.SchedulerDate__c = dt;                   
                if(usr !=null) sch.User__c = usr.id;
                update sch;
                
                System.Debug('sch = '+sch);
                System.Debug('updated successfully!!');
             }
             else {
               sch = new News__c();
               sch.Name = dayStr;  
               sch.SchedulerDate__c = dt;                   
               if(usr !=null) sch.User__c = usr.id;
               insert sch;
               System.Debug('sch = '+sch);
               System.Debug('Inserted successfully!!');
             }
         }catch(Exception ex) { // Display error message if any exceptions occurs
           Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()));
         }
         return null;
    
    }
    

    //Class to hold calendar event data

    public class calEvent{

        public String title {get;set;}

        public Boolean allDay {get;set;}

        public String startString {get;private set;}

        public String endString {get;private set;}

        public String url {get;set;}

        public String className {get;set;}

    }

}