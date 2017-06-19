global class MyOwnWebService{
    
    webservice static Integer DisplayResult(){
        Integer count=444;
        return count;
    }
    
    webservice static Integer DisplayClientResult(Integer a,Integer b){
        if(a!=Null || b!=Null){
        Integer sum=a+b;
        return sum;
        }else
        return null;
    }
    
    webservice static String DiplayStringResult(){
        
        String name='Welcome To Dhruvsoft';
        return name;
    }
    
    Webservice static Account DisplayAccountResult(){
        
        Account acc = [SELECT id,name,phone,description from Account where id ='0019000000SoXZz'];
        return acc;
    }
    
    Webservice static Account DisplayClientAccountResult(String AccId){
        
        Account acc = [SELECT id,name,phone,description from Account where id =:AccId];
        return acc;
    }
    
    Webservice static List<Account> DisplayAllAccountResult(){
        
        List<Account> acc = [SELECT id,name,phone,description from Account];
        return acc;
    }
}