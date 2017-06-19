trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    List<Task> tasks = new List<Task>();
    for(Opportunity opp : trigger.new){
        if(opp.StageName == 'Closed Won'){
            Task tk = new Task();
            tk.subject = 'Follow Up Test Task';
            tk.whatId = opp.id;
            tasks.add(tk);
        }
    }
    insert tasks;
}