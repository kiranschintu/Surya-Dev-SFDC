public class Governor{
    public List<Contact> contact{get;set;}
    
    public List<Contact> getmymethod(){
        contact=[SELECT id,name from Contact];
        return contact;
    }
}