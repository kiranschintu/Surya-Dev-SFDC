global with sharing class JSRemotingFileUploadController {
   // public static list<string> lstNewBody{get;set;}
    public JSRemotingFileUploadController(ApexPages.StandardController c) {
    }
     @RemoteAction
    public static String doUploadAttachment(String acctId, String attachmentBody, String attachmentName, String attachmentId) {
        if(acctId != null) {
            Account acct = getAccount(acctId);
            if(acct != null) {
                if(attachmentBody != null) {
                    Attachment att = getAttachment(attachmentId);
                    if(att.Body != null) {
                        att.Body = EncodingUtil.base64Decode( EncodingUtil.base64Encode(att.Body) +''+attachmentBody);
                      //  Blob neBody = EncodingUtil.base64Decode(attachmentBody);
                        //att.Body +=neBody;//EncodingUtil.base64Decode(attachmentBody);
                        //newBody = EncodingUtil.base64Encode(att.Body);
                    }else{
                        String newBody = attachmentBody;
                        att.Body = EncodingUtil.base64Decode(newBody);
                    
                    }
                    if(attachmentId == null) {
                        att.Name = attachmentName;
                        att.parentId = acct.Id;
                    }
                    upsert att;
                    return att.Id;
                } else {
                    return 'Attachment Body was null';
                }
            } else {
                return 'Account could not be found';
            }
        } else {
            return 'Account Id was null';
        }
    }
     
    @RemoteAction
    public static String doSubmitForm(String acctId, String description, String website, String phone) {
        if(acctId != null) {
            Account acct = getAccount('001j000000mCoyg');
            if(acct != null) {
                acct.Description = description;
                acct.Website = website;
                acct.Phone = phone;
                update acct;
                return 'Success';
            } else {
                return 'Account could not be found';
            }
        } else {
            return 'Account Id was null';
        }
    }
     
    private static Account getAccount(String acctId) {
        list<Account> accounts = [SELECT Id, Name
                                  FROM Account
                                  WHERE Id =: '0019000001giH1Z'];
        if(accounts.isEmpty()) {
            return null;
        } else {
            return accounts[0];
        }
    }
     
    private static Attachment getAttachment(String attId) {
        list<Attachment> attachments = [SELECT Id, Body
                                        FROM Attachment 
                                        WHERE Id =: attId];
        if(attachments.isEmpty()) {
            Attachment a = new Attachment();
            return a;
        } else {
            return attachments[0];
        }
    }
}