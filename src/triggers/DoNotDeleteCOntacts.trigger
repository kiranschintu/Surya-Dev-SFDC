trigger DoNotDeleteCOntacts on Account (before delete) {
    List<Contact> contacts = [select id,AccountId from Contact where Accountid IN:trigger.oldMap.keySet()];
    if(contacts!=null && !contacts.isEmpty()){
        for(Contact con:contacts){
            con.AccountId=null;
        }
        update contacts;
    }
}