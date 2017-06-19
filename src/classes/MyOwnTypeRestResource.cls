@RestResource(urlMapping='/user_defined_type_examples/*')
global with sharing class MyOwnTypeRestResource {

    @HttpPost
    global static MyUserDefinedClass doPost() {//MyUserDefinedClass ic
        
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        System.debug('Response to String >>>'+req.requestBody.toString());
        
        System.debug('JSON Untyped >>>'+JSON.deserializeuntyped(req.requestbody.tostring()));
        //System.debug('JSON Untyped >>>'+JSON.deserializeuntyped(req.requestbody.tostring()));
        
        MyUserDefinedClass mud= (MyUserDefinedClass)JSON.deserialize(req.requestBody.toString(), MyUserDefinedClass.class);
        system.debug('Result>>>'+mud);
        return mud;
    }

    global class MyUserDefinedClass {

        global String string1;
        global Integer inn;
        global String string2;
        //private String privateString;
        //global transient String transientString;
        

    }
    
}