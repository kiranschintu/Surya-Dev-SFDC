public class TestingClass{
    public static void dobest(){
    	List<Account> acc = [select id,description from Account];
        for(Account a:acc){
        a.description='Hello Test2';
            
        }
        update acc;
    }
}