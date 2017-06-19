public class NotesAttachmentModelController{
    public List<Attachment> attachmentList{set;get;}
    public List<Account> allAccounts{get;set;}
    public List<AttachmentModel> modelList{get;set;}
    public Integer srNo{get;set;}
    Account acc;
    public NotesAttachmentModelController(ApexPages.StandardController sc){
        acc = (Account)sc.getRecord();
        allAccounts = [SELECT id,name from account where id=:acc.id];
        attachmentList = [SELECT id,name,ContentType,OwnerId,ParentId from Attachment

                           where ParentId =: acc.id];
        system.debug('#################### value in Attachment List'+attachmentList);
        srNo=0;
        integer  i =0;
        modelList = new List<AttachmentModel>();
        for(Attachment att : attachmentList){
            AttachmentModel am = new AttachmentModel();
            am.srno = ++i;
            am.att = att;
            modelList.add(am);
        }
    }
    public class AttachmentModel{
        public Integer srNo{get;set;}
        public Attachment att{get;set;}
        public AttachmentModel(){
            srNo = 0;
            att = new Attachment();
             
        }
    }
}