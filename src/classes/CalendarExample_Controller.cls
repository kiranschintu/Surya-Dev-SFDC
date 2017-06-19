public with sharing class CalendarExample_Controller {
    public boolean includeMyEvents{get;set;}
    public List<calEvent> events{get;set;}
    String dtFormat = 'EEE, d MMM yyyy HH:mm:ss Z';
    
    public CalendarExample_Controller(){
        includeMyEvents=true;
    }
    
    public PageReference pageLoad(){
        events = new List<calEvent>();
        
        for(Contact cont: [select id,Birthdate,firstName,lastname from Contact where Birthdate!=null]){
            DateTime startDT = DateTime.newInstance(Date.Today().Year(),cont.Birthdate.Month(), cont.Birthdate.Day());
            
            calEvent bday = new calEvent();
            bday.title = cont.firstname + ' '+cont.LastName + '\'s Birthday!';
            bday.allDay= true;
            bday.startString= startDT.format(dtFormat);
            bday.endString= '';
            bday.url = '/'+cont.id;
            bday.className = 'event-birthday';
            
            events.add(bday);
        }
        system.debug('Events>>>'+events);
        
        for(Campaign camp : [select Id, Name, StartDate, EndDate from Campaign where IsActive = true]){
            DateTime startDT = camp.StartDate;
            DateTime endDT = camp.EndDate;
            calEvent campEvent = new calEvent();
            
            campEvent.title = camp.Name;
            campEvent.allDay = true;
            campEvent.startString = startDT.format(dtFormat);
            campEvent.endString = endDT.format(dtFormat);
            campEvent.url = '/' + camp.Id;
            campEvent.className = 'event-campaign';
            
            events.add(campEvent);
        }
        
        if(includeMyEvents){
            for(Event evnt: [select Id, Subject, isAllDayEvent, StartDateTime, EndDateTime from Event where OwnerID = :UserInfo.getUserId()]){
                DateTime startDT = evnt.StartDateTime;
                DateTime endDT = evnt.EndDateTime;
                calEvent myEvent = new calEvent();
                
                myEvent.title = evnt.Subject;
                myEvent.allDay = evnt.isAllDayEvent;
                myEvent.startString = startDT.format(dtFormat);
                myEvent.endString = endDT.format(dtFormat);
                myEvent.url = '/' + evnt.Id;
                myEvent.className = 'event-personal';
                events.add(myEvent);
                
            }
        }
        
        return null;
    }
    
    public class calEvent{
        public  String title{get;set;}
        public boolean allDay{get;set;}
        public  String startString{get;set;}
        public String endString{get;set;}
        public String url{get;set;}
        public String className{get;set;}
    }
    
}