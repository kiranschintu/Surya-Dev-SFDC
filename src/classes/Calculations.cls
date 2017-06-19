public class Calculations{
    private MathService maths;
    
    /*
    public Calculations(MathService maths){
        this.maths = maths;
    }
    public integer getResult(Integer a,Integer b){
        system.debug('Result+++'+maths.getCalculation(a,b));
        return maths.getCalculation(a,b);
        
    }
    */
    /****
    ------ Executing above Syntax ------
    Calculations cal = new Calculations(new Subtraction());
    cal.getResult(3,4);
    *****/
    
    /*
    public Calculations(){
        //always calls addition class logic
        maths = new Addition();
    }
    
    public integer getResult(Integer a,Integer b){
        system.debug('Result+++'+maths.getCalculation(a,b));
        return maths.getCalculation(a,b);
        
    }
    */
    /****
    ------ Executing above syntax ------
    Calculations cal = new Calculations();
    cal.getResult(3,4);
    *****/
    public static final Map<String,MathService> selection = new Map<String,MathService>();
    
    public Calculations(String selectedVal){
        selection.put('Add',new Addition());
        selection.put('Sub',new Subtraction());
        maths = selection.get(selectedVal);
    }
    
    public integer getResult(Integer a,Integer b){
        system.debug('Result+++'+maths.getCalculation(a,b));
        Integer result = maths.getCalculation(a,b);
        return result;
        
    }
    /****
    ------ Executing above syntax ------
    Calculations cal = new Calculations('Add');
    cal.getResult(3,4);
    *****/
}