// SOQL Checking

public class CheckFutureMainCon{
    
    public void docheck(){
        Account acc = [select id,name from Account limit 1];
        Account acc1 = [select id,name from Account limit 1];
        System.debug('Check%%%');
        cONTACT c = [select id,name,description from Contact limit 1];
        cONTACT c1 = [select id,name,description from Contact limit 1];
        //c.description = 'Test Update';
        update c;
        update c1;
        update acc;
        update acc1;
        update c;
    }
}