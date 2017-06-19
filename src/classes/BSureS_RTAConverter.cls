public class BSureS_RTAConverter {
    
    public static boolean stopRecursive=true;
   
    public static void convertImage(Account ctcs){
        system.debug('start==='+ctcs);
        //Retrieving salesforce BaseURL
        String basURL = URL.getSalesforceBaseUrl().toExternalForm();
        if(basURL.indexOf('visual.force.com')!=-1 && basURL.indexOf('//c.')!=-1){
            basURL = basURL.replaceAll('visual.force.com','salesforce.com');
            basURL = basURL.replaceAll('//c.','//');    
        }else{
            //Nestle production URL
            basURL = 'https://na2.salesforce.com';
        }
        
        Map<Blob,Document> docMap = new Map<Blob,Document>();
        Id orgId = [Select Id from Organization].Id;
        
        Map<String,List<Account>> ctctsToUpdateMp = new Map<String,List<Account>>();
        List<Document> docs = new List<Document>();
        
        Pattern ptrn = Pattern.compile('<img(.*?)src="https://c.(.*?)"(.*?)></img>');
        Pattern ptrn1 = Pattern.compile('<img(.*?)src="data:image/png;base64,(.*?)"(.*?)/>');
        Pattern ptrn2 = Pattern.compile('<img(.*?)src="data:image/jpeg;base64,(.*?)"(.*?)/>');
        Pattern ptrn3 = Pattern.compile('<img(.*?)src="https://c.(.*?)"(.*?)/>');
                
        Map<string,Pattern> patterns = new Map<string,Pattern>();
        patterns.put('imageserver',ptrn);
        patterns.put('base64png',ptrn1);
        patterns.put('base64jpg',ptrn2);
        patterns.put('imageserver1',ptrn3);
        
        Id folderId = [Select Id from Folder where Name='Supplier Review Comments Images'].Id;  //Please rename to your folder name here
            Integer counter =0;
            
            for(String key:patterns.keySet()){
                String imgData = ctcs.Image__c;
                imgData = imgData.unescapeHtml4();
                Pattern patrn = patterns.get(key);
                Matcher mtchr = patrn.matcher(imgData);
                while(mtchr.find()){
                    String grpData = mtchr.group(2);
                    if((key=='imageserver' || key=='imageserver1') && grpData.indexOf('ImageServer')==-1){
                        Document d = new Document();
                        String pgRef = 'https://c.'+grpData;
                        System.debug('PG Check>>>'+pgRef);
                        PageReference pg = new PageReference(pgRef);
                        Blob docBody = pg.getContent();
                        d.body = docBody;
                        d.FolderId = folderId;
                        d.name = 'New Image '+system.now();
                        d.IsPublic = true;//Crucial to ensure image is available publicly
                        d.ContentType='image/png';
                        d.type='png';
                        d.DeveloperName = generateAPI(counter);
                        counter++;
                        //d.description=grpData;
                        docMap.put(Crypto.generateDigest('MD5', docBody),d); //Put this in a map to retrieve later
                        system.debug('Doc>>>'+docMap);
                    }else if(key=='base64png' || key=='base64jpg'){
                        Document d = new Document();
                        Blob docBody = EncodingUtil.base64Decode(grpData);
                        d.body = docBody;
                        d.FolderId = folderId;
                        d.name = 'New Image '+system.now();
                        d.IsPublic = true;  //Crucial to ensure image is available publicly
                        d.ContentType='image/png';
                        d.type='png';
                        d.DeveloperName = generateAPI(counter);
                        counter++;
                        docMap.put(Crypto.generateDigest('MD5', docBody),d); //Put this in a map to retrieve later
                    }
                }
            }
        System.SavePoint sp = Database.setSavepoint();  //Savepoint to ensure we can rollback if update fails
        try{
            insert docMap.values();
            String imgData = ctcs.Image__c;
            imgData = imgData.unescapeHtml4();
            String newImgData='';            
            for(String key:patterns.keySet()){
                    Pattern patrn = patterns.get(key);
                    Matcher mtchr = newImgData!=null && newImgData!='' ? patrn.matcher(newImgData) : patrn.matcher(imgData);
                    while(mtchr.find()){    //Loop through matches and replace each image
                        String grpData = mtchr.group(2);       
                        if((key=='imageserver' || key=='imageserver1') && grpData.indexOf('ImageServer')==-1){
                            PageReference pg = new PageReference('https://c.'+grpData);
                            Blob docBody = pg.getContent();
                            Id docId = docMap.get(Crypto.generateDigest('MD5', docBody)).id;
                            newImgData=mtchr.replaceFirst('<img$1src="'+basURL+'/servlet/servlet.ImageServer?id='+docId+'&oid='+orgId+'"$3/>');
                            mtchr.reset(newImgData);
                        }else if(key=='base64png' || key=='base64jpg'){
                            Blob docBody = EncodingUtil.base64Decode(grpData);
                            Id docId = docMap.get(Crypto.generateDigest('MD5', docBody)).Id;
                            //The url used below is the publicly accessible one, different from the default url
                            newImgData=mtchr.replaceFirst('<img$1src="'+URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id='+docId+'&oid='+orgId+'"$3/>');
                            mtchr.reset(newImgData);        
                        }
                    }
                    if(newImgData!='' && newImgData!=null){
                        system.debug('newImgData ===='+newImgData);
                        ctcs.Image__c=newImgData;
                    }
            }
        }catch(Exception ex){
            Database.rollback(sp);
            throw ex;
        }
    }
    
    public static string generateAPI(Integer counter){
        String devName ='Img_'+userInfo.getUserId().right(8)+'_'+counter+'_'+system.today().year()+'_'+system.today().month()+'_'+system.today().day()+'_'+system.now().hour()+'_'+system.now().minute()+'_'+system.now().second()+'_'+system.now().millisecond();
        return devName;
    }
}