trigger BeforeInsertDesc on Account (before update) {
    for(Account a:trigger.new){
        a.description = 'Testing...';
        for(COntact c:[select id,description from Contact where AccountId=:a.id]){
            c.description = a.rating;
            update c;
        }
        COntact con = new Contact();
        con.lastname='Test';
        con.AccountId = a.id;
        insert con;
    }
}