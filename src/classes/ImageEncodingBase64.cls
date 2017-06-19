public class ImageEncodingBase64{
    public static void myimage(){
    	Account a=[select id,dhr__Image__c from Account where id='0019000000lRUOR'];
        Blob b=blob.valueOf(a.dhr__Image__c);
        string s = EncodingUtil.base64Encode(b);
        Blob afterb = EncodingUtil.base64Decode(s);
        system.debug('Image:'+a.dhr__Image__c);
        system.debug('Image:'+b);
        system.debug('Image:'+s);
        system.debug('Image:'+afterb);
    }
}