@isTest
public class testquickcontroller{

static testmethod void testmehod1(){
contact[] cc=new contact[]{
new contact(lastname='prasad',mobilephone='12345'),new contact(lastname='hello',mobilephone='123')};
insert cc;



ApexPages.StandardsetController strcontroller = new ApexPages.StandardsetController(cc);

quickEmailController qcc = new quickEmailController(strcontroller);
qcc.dosomething();
system.assert(cc[0].mobilephone != null);


}
}