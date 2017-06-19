public class RandomNumberGen {
    
    
     Account acc;
   
    Integer len = 17;
    Blob blobKey = crypto.generateAesKey(128);
    String key = EncodingUtil.convertToHex(blobKey);
    String pwd = key.substring(0,len);
    //String pwd1 = pwd.toUpperCase();
    
    DateTime dt = system.now();
    public String getNumber(){
        
        //return (Integer)(Math.random()*1000000);
        return pwd;
   }
   public DateTime getDattym(){
       return dt+1;
   }
   public pagereference copy(){
       acc =[select id,name,image__c from account where id ='0019000000O74Eq'];
       //Blob hash = Crypto.generateDigest('SHA1',Blob.valueOf(acc.image__c));
       Blob beforeblob = Blob.valueOf(acc.image__c);
       String hexDigest = EncodingUtil.base64Encode(beforeblob);
       //acc.image64__c =hexDigest;
       update acc;
       return null;
   }
   public Account getimage(){
   
       acc =[select id,name,image__c from account where id ='0019000000O74Eq'];
       String hexDigest = EncodingUtil.base64Encode(Blob.valueOf(acc.image__c));
       return acc;
   }

}