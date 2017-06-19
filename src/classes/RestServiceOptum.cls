@RestResource(urlMapping='/RestServiceOptum/*')
global class RestServiceOptum{
    @HttpPost
    global static void doSome(){
         RestRequest request = RestContext.request;  
         RestResponse response = RestContext.response;
         String jSONRequestBody = request.requestBody.toString().trim();
         system.debug('Reponse is::::'+request.requestBody);
         system.debug('Reponse is::::'+jSONRequestBody );

    }
}