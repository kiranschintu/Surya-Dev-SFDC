trigger DefaultContactOnOpp on Task (before insert,before Update,before Delete,after Undelete) {
   if(Trigger.isInsert){
   //Perform Action 1
   }
   if(Trigger.isUpdate){
   //Perform Action 2
   }
   if(Trigger.isDelete){
   //Perform Action 3
   }
   if(Trigger.isUndelete){
   //Perform Action 4
   }
}