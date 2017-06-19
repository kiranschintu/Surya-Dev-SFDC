public with sharing class AccountDispCon {
    public Account acc{get;set;}
    public AccountDispCon(){
        Id aid = ApexPages.currentPage().getParameters().get('id');
        acc = [select id,name,image__c from Account where id=:aid];
        
        
  
    }
    
    public void sendEmail(){
        // Step 0: Create a master list to hold the emails we'll send
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
      // Step 2: Set list of people who should get the email
      List<String> sendTo = new List<String>();
      sendTo.add('kirans.chintu@gmail.com');
      mail.setToAddresses(sendTo);
    
      // Step 4. Set email contents - you can use variables!
      mail.setSubject('URGENT BUSINESS PROPOSAL');
      String body = 'Dear ';
      body += 'Please check below';
      body += '<br/><img src="http://i.ytimg.com/vi/bDumkqFs2mk/maxresdefault.jpg" alt="test message">';
      
      mail.setHtmlBody(body);
    
      // Step 5. Add your email to the master list
      mails.add(mail);
      
      // Step 6: Send all emails in the master list
      Messaging.sendEmail(mails);
    
    }
   
}