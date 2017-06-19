global class MyFirstSOAPWebservice{
    webservice static List<Account> displayAccounts(){
        List<Account> acc = [select id,name,phone from Account];
        return acc;
    }
    webservice static Account displayAccount(String accname){
        Account acc = [select id,name,phone from Account where name =:accname];
        return acc;
    }
}