public class ChaniPageCTRL{
    //ApexPages.StandardSetController controller = new Apexpages.StandardSetController([SELECT id FROM Account LIMIT 1]);
    //ApexPages.StandardController controller = new ApexPages.StandardController(Database.getQueryLocator('select id from account limit 1'));
    //ApexPages.StandardController controller = new ApexPages.StandardController ([SELECT id FROM Account LIMIT 1]);
    ApexPages.StandardSetController controller = new ApexPages.StandardSetController(database.getQueryLocator('select id from Account Limit 1'));
    public ChaniPageCTRL(){
        system.debug('Done:::'+controller.getListViewOptions());
    }
}