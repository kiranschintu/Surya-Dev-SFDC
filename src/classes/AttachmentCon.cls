public with sharing class AttachmentCon {
    
    public Void CreateAttachment(){
        Attachment attach=new Attachment();
        
        List<Task>  task = [Select id,subject,description from Task where whatID='0019000000SoXZz']; 
        String bodyStr='Task Id'+','+'Task Subject'+','+'Description' ;
        For(Task t:task){
        bodyStr+='\n'+
            t.id + ',' +'"'+t.subject+'"'+','+t.description;
        }
        
        //attach.Body=Blob.valueOf(bodyStr);
       PageReference pg=page.AttachmentPdf;
       Blob b=pg.getContent();
       attach.body=b;
       attach.Name='NewAttachment.pdf';
        attach.parentId='0019000000SoXZz';
        insert attach;
    }
}