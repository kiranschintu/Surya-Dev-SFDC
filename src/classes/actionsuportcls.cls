public with sharing class actionsuportcls
{
    public String name { get; set; }
   
    public void changename()
    {
        name='Sales';
        system.debug('Check It');
    }
    public void unchangename()
    {
        name='Force.com';
    }
}