public class Collections{
    public static void listmethods(){
    	List<Integer> myList = new List<Integer>();
        myList.add(333);
        
        List<String> ss = new List<String>();
        ss.add('sss,SFSD,WETRT,WERTWERWE');
        ss.add('s');
        ss.add('ss');
        ss.add('Name');
        system.debug('Element '+ss.get(0));
        if(ss.get(0).contains('sss'))
        system.debug('True');
        
        /*
		system.debug('myList add():'+myList);
        List<Integer> myList1 = new List<Integer>();
        myList1.addAll(myList);
        Set<Integer> mySet = new Set<Integer>();
        mySet.add(444);
        myList1.addAll(mySet);
        system.debug('myList1 addAll():'+myList1);
        List<Integer> myList2 = new List<Integer>();
        myList2 = myList1.clone();
        system.debug('myList1 Clone() :'+myList2);
        List<Account> myAccount = new List<Account>();
        myAccount.add(new Account(Name='Hello'));
        system.debug('myAccount add():'+myAccount);
        List<Account> myAccount1 = new List<Account>();
        myAccount1 = myAccount.deepClone();
        myAccount1.add(new Account(Name='Hello 1'));
        system.debug('myAccount1 Clone():'+myAccount1);
        system.debug('myAccount1 get():'+myAccount[0].get('Name'));*/
        
    }
}