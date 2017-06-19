trigger dupeblocker on Account (before insert) {
    
    List<Account> acc = [select id,name,phone from account];
    
    for(Account account:Trigger.new){
        for(Account ac:acc){
            if(ac.phone==account.phone)
            account.addError('Duplicate found');
        }    
    
    }
}