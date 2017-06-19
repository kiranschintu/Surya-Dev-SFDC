trigger TestEmail on Contact (before update) {
 Integer i=1;
    List<Account> acc = [select id,phone from account];
    for(Contact c : Trigger.new) {
    for(account a:acc){
        if(a.id ==c.accountid){
        c.Lastname =c.lastname;
        }
    }
    
    }
 
}