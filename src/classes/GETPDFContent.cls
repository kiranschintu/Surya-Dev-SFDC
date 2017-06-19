/**
*   Created By  :   Surya
*   Description :   Apex based REST API which exposes POST method to send Email
*/
@RestResource(urlMapping='/sendPDFEmail/*')
Global class GETPDFContent{
    @HttpGet
    global static void sendEmail() {
        System.debug('Hello Service');
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        List<String> recps = new List<String>();
        recps.add('suryakiran.c@vertexcs.com');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setSubject('Hello');
        mail.setPlainTextBody('Hello This is Body');
        mail.setToAddresses(recps);
        
        // Reference the attachment page, pass in the account ID
        PageReference pdf = Page.ContactsOfAcc;
        pdf.getParameters().put('aid','0019000000CJMV5AAP');
        pdf.setRedirect(true);
        
        // Take the PDF content
        Blob b = pdf.getContent();
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName('attachment.pdf');
        efa.setBody(b);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[]{efa});
        
        mails.add(mail);
        
        Attachment atch = new Attachment();
        atch.ParentId = '0019000000CJMV5AAP';
        atch.body = b;
        atch.name='MyAttachment.pdf';
        insert atch;
        
        //Messaging.sendEmail(mails);
    }
}