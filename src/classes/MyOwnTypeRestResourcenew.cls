@RestResource(urlMapping='/user_defined_type_example/*')
                        
global with sharing class MyOwnTypeRestResourcenew {

    @HttpPost
    global static MyUserDefinedClass echoMyType(MyUserDefinedClass ic) {
        return ic;
    }

    global class MyUserDefinedClass {

        global String string1;
        global String string2 { get; set; }
        private String privateString;
        global transient String transientString;
        global String staticString;

    }
    
}