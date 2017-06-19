public class bulkrowithindex {

    public PageReference removeItem() {
        return null;
    }


    public List<Account> memberIndexes{get;set;}
    
    public bulkrowithindex(){
        memberIndexes = new List<Account>();
        for(Integer i=0;i<3;i++){
            Account acc = new Account();
            memberIndexes.add(acc);
        }
    }
    
    public List<Integer> getArrayIndexes(){
        List<Integer> indexes = new List<Integer>();
        for(integer i = 0; i < (memberIndexes.size()-1); i++)
            indexes.add(i);
        return indexes;
    }

}