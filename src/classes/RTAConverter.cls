public class RTAConverter {
    Map<Blob,Document> docMap;
    static Id orgId = [Select Id from Organization].Id;
    
    public RTAConverter(){
         docMap = new Map<Blob,Document>();
    }
    
    public void convertImage(List<Account> ctcs){
        //Reselect contacts using SOQL since we get them from an after update trigger
        List<Account > contacts = [Select Id,dhr__Image__c from Account where Id in :ctcs];
        List<Account > ctctsToUpdate = new List<Account >();
        Pattern ptrn = Pattern.compile('<img(.*?)src="data:image/jpeg;base64,(.*?)"(.*?)></img>');
        Matcher mtchr = ptrn.matcher('');
        Id folderId = [Select Id from Folder where Name='Images'].Id;   //Please rename to your folder name here
        system.debug('*********folderId*********'+folderId);
        system.debug('*********contacts*********'+contacts);
        for(Account con:contacts){
            Integer counter =0;
            String imgData = con.dhr__Image__c;
            system.debug('*************imgData *****'+imgData );
            mtchr.reset(imgData);   //Initialize the matcher with the Rich Text Area data
            while(mtchr.find()){
                if(counter++==0){
                    ctctsToUpdate.add(con);   //Add the contact to the final update list, no more than once
                }
                String data = mtchr.group(2);   //This is the base64 image string
                Document d = new Document();
                Blob docBody = EncodingUtil.base64Decode(data);
                d.body = docBody;
                d.FolderId = folderId;
                d.name = 'New Image '+system.now();
                d.IsPublic = true;  //Crucial to ensure image is available publicly
                d.ContentType='image/jpeg';
                d.type='jpg';
                d.DeveloperName='New_Image_'+con.Id+'_'+Datetime.now().millisecond();
                docMap.put(Crypto.generateDigest('MD5', docBody),d); //Put this in a map to retrieve later
            }
        }
        System.SavePoint sp = Database.setSavepoint();  //Savepoint to ensure we can rollback if update fails
        try{
            insert docMap.values();
            system.debug('******docMap.values()*********'+docMap.values());
            system.debug('******ctctsToUpdate*****'+ctctsToUpdate);
            for(Account con:ctctsToUpdate){
                String imgData = con.dhr__Image__c;
                mtchr.reset(imgData);
                String newImgData='';
                while(mtchr.find()){    //Loop through matches and replace each image
                    Blob docBody = EncodingUtil.base64Decode(mtchr.group(2));
                    Id docId = docMap.get(Crypto.generateDigest('MD5', docBody)).Id;
                    //The url used below is the publicly accessible one, different from the default url
                    newImgData=mtchr.replaceFirst('<img$1src="'+URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+docId+'&oid='+orgId+'"$3></img>');
                    mtchr.reset(newImgData);                    
                }
                con.dhr__Image__c=newImgData;
            }
            
            update ctctsToUpdate;
            system.debug('Replace completed'); 
        }catch(Exception ex){
            Database.rollback(sp);
            throw ex;
        }
    }
}