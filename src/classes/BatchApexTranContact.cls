global class BatchApexTranContact implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT id,name,phone from Contact]);
    }
    global void execute(Database.BatchableContext bc,List<Contact> scope){
        List<Contact> con=new List<Contact>();
          
          /*
           for(sObject s:scope){
               Contact c=(Contact)s;
               c.phone='123458';
               con.add(c);
           }
        update con;*/
        
        for(Contact c:scope){
            c.phone='1111';
            con.add(c);
            }
            update con;
    }
    global void finish(Database.BatchableContext bc){
    
    }
}