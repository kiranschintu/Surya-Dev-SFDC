public class VFCOmpsCon {

    public Account wpObject { get; set; }
    public VFCOmpsCon(){
        wpObject = [select id,name from Account where id In(select AccountId from Contact) limit 1];
    }
}