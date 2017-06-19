public class SOQLQueryCount {
    public static void check(){
        List<Account> acc = [select id,name,(Select id from Contacts) from Account];
        system.debug('Used Queries>>>'+Limits.getQueries());
    }
}