public class ListsAndSets{
    public static void dosome(){
    	List<Integer> i=new List<Integer>();
        i.add(1);
        i.add(2);
        i.add(3);
        
        Set<Integer> s=new Set<Integer>();
        s.add(22);
        s.add(44);
        i.addAll(s);
        S.addAll(i);
        
        Map<Integer,Integer> m=new Map<Integer,Integer>();
        m.put(1,11);
        i.addAll(m.values());
        S.addAll(M.values());
        for(Integer ii:i){
        	m.put(ii, ii);
        }
        
        system.debug('List elements : '+i);
        system.debug('Set elements : '+s);
        system.debug('Map elements : '+m);
        
    }
}