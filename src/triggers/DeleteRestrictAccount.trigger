trigger DeleteRestrictAccount on Account (before delete) {
    /*for(Account acc :[select id from Account where id IN (select AccountId from Contact) AND id IN:trigger.oldMap.keySet()]){
        trigger.oldMap.get(acc.id).addError('You can not delete this Account with Contacts');
    }*/
    
    for(Account acc:[select id,name from Account where id IN (select AccountId from Contact where AccountId IN: trigger.oldMap.keySet()) AND id IN:trigger.oldMap.keySet()]){
        if(!acc.Contacts.isEmpty()){
            trigger.oldMap.get(acc.id).addError('You cannot delete this Account');
        }
    }
}