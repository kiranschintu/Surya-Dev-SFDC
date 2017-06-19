trigger AccountUpdate1 on Account (before insert,before update,before delete,after update,after insert) {
 
 if(Trigger.isBefore){
 if(Trigger.isInsert || Trigger.isUpdate ){
 for(Account a:Trigger.new){
     a.description='Hello Rajendra';
     if(a.phone.length()<10)
     a.phone.addError('Invalid Phone Number');
 }
 }
 if(Trigger.isDelete){
 List<Contact> con=[SELECT id,AccountId from Contact];
 for(Account a:Trigger.old){
 //List<Contact> con=[SELECT id from Contact where AccountID =:a.id];
 for(Contact c:con)
 if(a.id==c.accountid)
 a.addError('You can not delete this account as it has contact records');
 }
 }
 }
 if(Trigger.isafter){
 List<Contact> con=[SELECT id,AccountId from Contact];
 List<Contact> cons=new List<Contact>();
 for(Account a:Trigger.new){
 for(Contact c:con){
     if(c.AccountId==a.id){
     c.phone=a.phone;
    cons.add(c);
     }
 }    
 }
  update cons;
 }
 
}