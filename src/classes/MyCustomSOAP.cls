global class MyCustomSOAP{
    webservice static List<Account> displayacc(){
        List<Account> acc = [select id,name from Account limit 3];
        return acc;
    }
}