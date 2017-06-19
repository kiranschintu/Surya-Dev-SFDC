trigger updateAccountPhone on Account (after update) {
    List<contact> con=[select phone,account.phone from contact where Accountid
                       IN:Trigger.old FOR UPDATE];
    for(Contact c:con){
        c.phone = c.account.phone;
    }
    update con;
}