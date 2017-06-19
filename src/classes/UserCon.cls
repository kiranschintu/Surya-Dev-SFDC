global class UserCon {

    public User user; 
    public UserCon(ApexPages.StandardController controller) {
     this.user = (User)controller.getRecord();
    }
   /* public pagereference doupdate(){
    user.phone='8125931509';
    user.isactive=False;
    update user;
    return null;
    }*/
    
    webservice static String doUpdate(String phone,Boolean Status) {
    User user= [select name,phone from User where id='005900000010Se8'];
    user.phone =phone;
    user.isactive =Status;
    try{
    update user;
    return 'success';
    }catch(Exception e){
    return 'Fail';
    }
}
}