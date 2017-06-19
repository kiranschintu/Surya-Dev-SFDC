public with sharing class AccountHandler{
    public static Account insertNewAccount(string aname){
        try{
            Account acc = new Account(name=aname,phone='1234567896');
            insert acc;
            return acc;
        }catch(Exception e){
            return null;
        }
    } 
}