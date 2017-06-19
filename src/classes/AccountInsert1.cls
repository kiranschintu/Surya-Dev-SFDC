public class AccountInsert1 extends AccountInsert{
    public override string DoInsert(){
        String accid = super.DoInsert();
        if(accid==null){
            Account acc = new Account();
            acc.name = 'Test';
            insert acc;
            return acc.id;
        }else{
            Account acc = new Account();
            acc.id = accid;
            acc.Phone = '9999999999';
            update acc;
            return acc.id;
        }    
    }
    
    public void dosome(){
        system.debug('Account Inserted :'+super.DoInsert());
    }
}