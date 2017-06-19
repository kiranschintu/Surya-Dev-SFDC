trigger ContactsSize on Account (after insert,after update) {
  if(!trigger.isUpdate){
    Set<Id> AIds = new Set<Id>();
    for(Account acc:Trigger.new)
    AIds.add(acc.id);
    
    
    List<Account> accs = [select id,name,(select id,lastname from contacts) from Account where id in:AIds];
   // List<Contact> con = [select id,lastname,description from contact where accountid in : AIds ];
    List<Contact> cons = new List<Contact>();
    for(Account acc:accs)
    {
            if(acc.contacts.isEmpty()){
            Contact cons1 = new Contact();
            cons1.accountid = acc.id;
            cons1.lastname = 'one';
            cons.add(cons1);
            }/*else if (!acc.contacts.isEmpty()){
            for(Contact c:con ){
             c.description = 'Hello desc this is from Account';
            }
            }*/
    }
    if(!cons.isEmpty())
    insert cons;
    //update con;
 }   
    
}