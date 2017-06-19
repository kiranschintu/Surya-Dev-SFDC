public class Tran4 {

    Public List<Account> acc;
    public Tran4(ApexPages.StandardSetController controller) {
        this.acc=(List<Account>)controller.getSelected();
       // acc=[select id,name,phone from Account where id in: controller.getSelected()];
    }
   /* public List<Account> acc(){
        //acc=[select id,name from Account];
        return acc;
    }*/


}