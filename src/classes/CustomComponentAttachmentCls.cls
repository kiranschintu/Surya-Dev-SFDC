global with sharing class CustomComponentAttachmentCls {
    global Blob body{get;set;}
    global string bodystr{get;set;}
    global Attachment attach{get;set;}
    global CustomComponentAttachmentCls(){
        //body = new Blob();
        attach = [select id,body from Attachment where id='00P9000000PeUJh'];
        bodystr = EncodingUtil.base64Encode(attach.body);
        
    }
}