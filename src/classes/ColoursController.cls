public class ColoursController {
    public List<ColourClassBase> colours{get;set;}
 
    public ColoursController(){
        colours = new List<ColourClassBase>();
 
        colours.add(new ColourClassBase());
        colours.add(new Orange());
        colours.add(new Green());
    }
}