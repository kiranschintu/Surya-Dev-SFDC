public with sharing class ContactSearch{
    public static List<Contact> searchForContacts(string lname,string pocode){
        List<Contact> cons = [select id,name from Contact where lastname =:lname and MailingPostalCode=:pocode];
        return cons;
    }
}