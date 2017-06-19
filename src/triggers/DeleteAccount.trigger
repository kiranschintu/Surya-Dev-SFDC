trigger DeleteAccount on Account (before insert) {
    
    for(Account a:Trigger.new){
       //if(a.Name=='surya')
       a.Name.addError('You can not delete Account');
    }
}