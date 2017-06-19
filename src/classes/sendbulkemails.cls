public class sendbulkemails {
    public pageReference SendEmail()
    {
        List<contact> lstcon=[Select id from contact limit 6];
        List<Id> lstids= new List<Id>();
        for(Contact c:lstcon){
        lstids.add(c.id);    
    }
    EmailTemplate et=[Select id from EmailTemplate where name=:'For Custom Emails'];
    Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
    mail.setTargetObjectIds(lstids);
    mail.setTemplateId(et.id);
    mail.setDescription('This is from sfdc');
    mail.setSenderDisplayName('kiran');
    
    Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
    ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.confirm, 'Email Send successfully');
             ApexPages.addMessage(msg);
        return null;
    return null;
}
}