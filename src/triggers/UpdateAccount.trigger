trigger UpdateAccount on Contact (after update) {
    
    for(Integer i=0;i<90;i++){
        system.debug('Query>>>'+[select id,name from Account limit 10]);
    }
    
    for(Contact con:trigger.new){
        for(Account a:[select id,name from Account where id =:con.AccountId]){
        update a;
        }    
    }
    
    
}