public class AngularJS7CTRL {
    @RemoteAction
    public static string doSome(){
        MyResponse mr = new MyResponse();
        mr.name='Surya';
        mr.email='test@gmail.com';
        return JSON.Serialize(mr);
    }
    public class MyResponse{
        public string name{get;set;}
        public String email{get;set;}
    }
}