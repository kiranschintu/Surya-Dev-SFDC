public without sharing class SecurityCheckChild{
    
    public static List<Lead> doTest(){
        return [select id,name from Lead];
    }
}