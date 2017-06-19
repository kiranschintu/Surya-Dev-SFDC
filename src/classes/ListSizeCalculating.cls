public class ListSizeCalculating{
public static void dosome(){
        List<Contact> con=[select id from contact];
        system.debug('Size :'+con.size());
    }
}