public class YellowMarker extends Marker{
    public override String write(String a){
        string ss = super.write(a);
        system.debug('Extended Class Yellow Marker');
        return a;
    }
}