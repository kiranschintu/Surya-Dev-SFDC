public class testemail
{
    public testemail(ApexPages.StandardSetController controller)
  {
     con = [select Id,name from Contact where title='x' limit 3];
     for(Integer i=0;i<3;i++)
     {
         contactids.add(con[i].Id);
      }  
  }
    
  private final List<Id> contactids;
  public List<Contact> con;
 /* public testemail(ApexPages.StandardController controller)
  {
     con = [select Id,name from Contact where title='x' limit 3];
     for(Integer i=0;i<3;i++)
     {
         contactids.add(con[i].Id);
      }  
  }*/

  public void SendEmail()
  {
       Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
       mail.setTargetObjectIds(contactids);
       mail.setTemplateId('00X90000000TonO');
       Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
  }  


}