public class AngularJSBtnClick1CTRL {
    public static string myName{get;set;}
    @RemoteAction
    public static String doSome(String fileData){
        MyWrapper wrpRes = new MyWrapper();
        wrpRes.name='Surya';
        wrpRes.age='27';
        
        return Json.serializepretty(wrpRes) ;
    }
    
    public class MyWrapper{
        public String name{get;set;}
        public String age{get;set;} 
    }
}