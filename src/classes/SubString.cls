public class SubString{
	static String color = 'blue@grey.com\n1\n2\n3\n4\n5\n6\n7\n8\n9\nA\nB\nC\nD\nE\nF\nG\nH\nI\nJ\nK\nL\nM\nO\nP\nG\nH\nI\nJ\nK\nL\nM\nO\nP';
	static Integer m_index = 0;
    static String m_rowDelimiter = '\n';
    static string colorr =color;
	/*public static void dosub(){
    	Integer key = color.indexOf(m_rowDelimiter, m_index);
        system.debug('Key idexof :'+key);
        if (key == -1)
        key = color.length();
        system.debug('String Length :'+color.length());
        String row = color.subString(m_index, key);
        system.debug('LINE :'+row);
        m_index = key + 1;
   }*/
    public static void dosub1(){
        List<String> lsr = new List<String>();
        List<String> lsr1 = new List<String>();
        
        Integer key;
        Integer x=0;
        Integer d=3;
        system.debug('Length'+color.length());
        //Integer k=color.length();
        for(Integer i=0;i<3;i++){
        system.debug('Main String Length :'+colorr.length());
        while(m_index<=color.length()/d){
            key = color.indexOf(m_rowDelimiter, m_index);
            
            if (key == -1)
            key = color.length();
            //system.debug('String Length :'+color.length());
            String row = color.subString(m_index, key);
            //system.debug('LINE :'+row);
            m_index = key + 1;
            //system.debug('m_index :'+m_index);
            lsr.add(row);
            //system.debug('Key indexof in loop :'+key);
            //system.debug('m_index in loop'+m_index);
        }
        String sss = color.substring(X,key);
        
        system.debug('x'+X);
        system.debug('m_index'+m_index);
        system.debug('Key'+key);
        system.debug('Sheet :'+I+':'+sss);
            //x=m_index;
            if(d!=1)
            d=d-1;
            
          integer k=color.length();
         system.debug('color length & M_INDEX USING IN SUBSTRING:'+m_index+':'+color.length());
       if(color.length()>m_index)
        color= color.substring(m_index,color.length());
        //color= color.substring(0,39);
        
            system.debug('Color 2 size'+color.length());
        m_index=0;
        //color = color.substring(m_index,color.length());
        //system.debug('Sheet 2 size'+color.length());
        //system.debug('Sheet 2'+color);
        
        }
        
        //system.debug('Total Rows :'+lsr);
        //system.debug('Key Out side of While :'+KEY);
        //system.debug('m_index Out side of While  :'+m_index);
        //String sss = color.substring(0,key);
        //system.debug('Total Sheet :'+color);
        //system.debug('First Sheet :'+sss);
        //Integer subm_index = m_index;
        
        /*while(m_index<color.length()){
            key = color.indexOf(m_rowDelimiter, m_index);
            //system.debug('Key idexof :'+key);
            if (key == -1)
            key = color.length();
            //system.debug('String Length :'+color.length());
            String row = color.subString(m_index, key);
            //system.debug('LINE :'+row);
            m_index = key + 1;
            //system.debug('m_index :'+m_index);
            lsr1.add(row);
        }*/
        //key =color.length();
        //String ssss = color.substring(subm_index,key);
        //system.debug('Second Sheet:'+ssss);
        //system.debug('Remaining Rows'+lsr1);
    }
}