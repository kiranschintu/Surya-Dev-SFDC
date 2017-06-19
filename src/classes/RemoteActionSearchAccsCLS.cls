global with sharing class RemoteActionSearchAccsCLS {
    static Account accs;
    static List<Account> allAcc;
    @RemoteAction
    global static Account getAccs(String name){
        String aName = name+'%';
        accs = [select id,name,phone from Account where name like :aName limit 1];
        return accs;
    }
    
    @RemoteAction
    global static List<Account> dispAccs(String accname){
        String aname = accname+'*';
        List<List<SObject>> searchList = [FIND :aname IN ALL FIELDS RETURNING Account (Id, Name,phone)];
        
        
        allAcc = searchList[0];
        return allAcc;
    }
}