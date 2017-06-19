public virtual class AccountInsert{
    public virtual string DoInsert(){
        Account acc = new Account();
        acc.name = 'Test';
        insert acc;
        return acc.id;
    }
}