public class TestMYPrivateConstructor {
    private TestMYPrivateConstructor(){
        system.debug('Private Constructor');
    }
    public static void check1(){
        system.debug('Static method');
    }
    
    public void check2(){
        system.debug(' Non - Static method');
    }
}