public class PDevCertificationCTRL {
    public string myString{get;set;}
    public String getStringMethod1(){
        return myString;
    }
    
    public String getStringMethod2(){
        if(myString == null)
        myString='Method2';

        return myString;
    }
}