public class josnexm1con {
    String JSONContent = '{"firstName":"John"}';
    JSONParser parser =  JSON.createParser(JSONContent);
public PageReference records(){
    while (parser.nextToken() != null) 
        System.debug('Current token: ' +parser.getCurrentToken());
        ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.info,'hiii'+parser.getCurrentToken());
        ApexPages.addMessage(msg);
        return null;
}
    }