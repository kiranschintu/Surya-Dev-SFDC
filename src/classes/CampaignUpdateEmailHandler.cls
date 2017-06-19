global class CampaignUpdateEmailHandler implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(
  Messaging.InboundEmail email,
  Messaging.InboundEnvelope envelope)
  {
    String subject = email.subject;
    decimal cnt=0;
    Pattern idPattern = Pattern.compile('001[A-Za-z0-9]{12}');
    Matcher matcher = idPattern.matcher(subject);
     //if the email body contains account id then a account is udated
    if (!matcher.find())
    {
     System.assert(false, 'No Account Id in subject!');
    }
   else
   {
    Account account = [SELECT Name FROM Account WHERE Id = :matcher.group(0)];
    //account.Name = email.plainTextBody;
    //system.debug('account.NoOfEmailsReplied__c is ==='+account.NoOfEmailsReplied__c);
    //if(account.NoOfEmailsReplied__c==null){cnt=1;}
   // else{
    //cnt=  account.NoOfEmailsReplied__c;
    //cnt=cnt+1;
   // }
    
    system.debug('cnt is ==='+cnt);
    //account.NoOfEmailsReplied__c=cnt;
    update account;
    }
    Messaging.InboundEmailresult result = new Messaging.InboundEmailResult();
    result.message = 'Account Name is now ' + account.Name;
    return result;
  }
}