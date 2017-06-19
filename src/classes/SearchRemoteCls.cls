global class SearchRemoteCls {
    static List<Account> allAcc;
    @RemoteAction
    global static List<Account> dispAccs(String accname){
        String aname = accname+'*';
        List<List<SObject>> searchList = [FIND :aname IN ALL FIELDS RETURNING Account (Id, Name,phone)];
        
        
        allAcc = searchList[0];
        return allAcc;
    }
}