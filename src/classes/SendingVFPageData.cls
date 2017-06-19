global with sharing class SendingVFPageData implements Schedulable{
    global void execute(SchedulableContext sc){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        List<String> recps = new List<String>();
        recps.add('suryakiran.c@vertexcs.com');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Hello');
        mail.setPlainTextBody('Hello This is Body');
        mail.setToAddresses(recps);
        
        // Reference the attachment page, pass in the account ID
        PageReference pdf = Page.ContactsOfAcc;
        pdf.getParameters().put('aid','0019000001FxfdQ');
        pdf.setRedirect(true);
        
        // Take the PDF content
        Blob b = pdf.getContent();
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('attachment.pdf');
        efa.setBody(b);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[]{efa});
        
        
        mails.add(mail);
        
        Messaging.sendEmail(mails);

    }
}