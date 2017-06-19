public class ContentVersionCon{
    public static void contentdate(){
        ContentVersion cv = [select id,Title,FileType,VersionData from ContentVersion where title='Asia PL 12-5-13'];
        system.debug('Content Version :'+cv);
        Blob bodyBlob = cv.VersionData;
		String bodyStr = bodyBlob.toString(); 
        //system.debug('Body :'+bodyStr);
        List<string> bodystr1 = new List<String>(); 
           bodystr1 = bodystr.split('\n');
        Integer i=0;
        for(String b:bodystr1){
        	system.debug('Row '+i+' : '+b);
        }
    }
}