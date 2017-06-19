public class ActionPollarCTRL{
    public integer count{get;set;}
    
    public ActionPollarCTRL(){
        count=0;
    }
    public PageReference checkCounter(){
        PageReference pg;
        if(count==3){
            pg = new PageReference('/apex/WrapperSorting1');
            pg.setRedirect(true);
        }
        count++;
        return pg;
    }
}