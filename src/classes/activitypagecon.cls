public class activitypagecon {

    public activitypagecon(ApexPages.StandardSetController controller) {

    }

    public activitypagecon(ApexPages.StandardController controller) {

    }
    public list<task> t;
    
    public List<task> getrecords(){
        t=[select subject,description from task where id='0039000000DzcjX'];//:ApexPages.currentPage().getParameters().get('id')];
        return t;
    }

}