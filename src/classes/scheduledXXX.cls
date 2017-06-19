global class scheduledXXX implements Schedulable{ 
  global void execute(SchedulableContext SC) {
     MassUpdateDescriptionAcc tB = new MassUpdateDescriptionAcc() ;
     Database.executeBatch(tb);
  }
}