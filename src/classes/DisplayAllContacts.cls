public class DisplayAllContacts{

    public static void ContactRecords(){
        
        List<Contact> con = [SELECT Name,Account.Name from Contact limit 100];
        system.debug('List Size : '+con.size());
        
    }
}