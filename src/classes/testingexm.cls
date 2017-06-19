@isTest
public class testingexm{
static testmethod void question()
{
sendingemailcon demo = new sendingemailcon();
demo.sendEmail();
/*test.starttest();

Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
String[] toAddresses = new String[] {'xxx@gmail.com'};
mail.setToAddresses(toAddresses);
mail.setSenderDisplayName('Hello rahul');
mail.setSubject('subject');
mail.setHtmlBody('abcd');
test.stoptest();*/
}
}