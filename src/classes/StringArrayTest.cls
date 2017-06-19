public with sharing class StringArrayTest{
    public static List<String> generateStringArray(Integer size){
        List<String> newlist = new List<String>();
        for(integer i=0;i<size;i++){
            newlist.add('Test '+i);
        }
        return newlist;
    }
}