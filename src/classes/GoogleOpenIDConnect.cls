global class GoogleOpenIDConnect implements Auth.RegistrationHandler{
  global User createUser(Id portalId, Auth.UserData data){
    User u = new User();
    Profile p = [SELECT Id FROM profile WHERE name='Standard User'];
    u.username = data.email;
    u.email = data.email;
    u.lastName = data.lastName;
    u.firstName = data.firstName;
    u.timeZoneSidKey = 'UTC';
    u.localesidkey = data.locale;
    u.emailEncodingKey = 'ISO-8859-1';
    u.languagelocalekey = data.locale;
    String alias = data.firstName + data.lastName;
    if(alias.length() > 8) {
      alias = alias.substring(0, 8);
    }
    u.alias = alias;
    u.profileId = p.Id;
    return u;
  }

  global void updateUser(Id userId, Id portalId, Auth.UserData data){
    User u = new User(id=userId);
    u.email = data.email;
    u.lastName = data.lastName;
    u.firstName = data.firstName;
    update(u);
  }
}