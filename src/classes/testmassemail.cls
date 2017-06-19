public class testmassemail
{
  private final List<Id> contactids;
  public List<Contact> con;
  public testmassemail()
  {
     con = [select Id from Contact limit 3 ];
     for(Integer i=0;i<3;i++)
     {
         contactids.add(con[i].Id);
      }  
  }

  public void SendEmail()
  {
       Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
       mail.setTargetObjectIds(contactids);
       //mail.setTemplateId('00X90000000QHUD');
       Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
  }  


}