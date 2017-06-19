trigger ContactUpdate on Account (after update) {
    
    Map<Id,Account> myaccmap = new Map<Id,Account>([select id,phone from Account where id in:Trigger.newMap.keySet()]);
    List<Contact> contacts = new List<Contact>();
    for(Contact c:[SELECT id,accountid,phone from Contact where AccountId!=Null and AccountId in:myaccmap.keySet()]){
        //if(myaccmap.containsKey(c.accountId) && myaccmap.get(c.AccountId).phone!=null){
          //  c.phone = myaccmap.get(c.AccountId).phone;    
            contacts.add(c);
        //}
    }
    if(!contacts.isEmpty())
    update contacts;
    
}