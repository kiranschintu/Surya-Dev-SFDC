public class gettingemail{
    public List<Contact> con;
    public void contactemails(){
        con = [select email from Contact limit 3];
    }
}