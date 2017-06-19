trigger MynewFuturetest on Contact (before update) {
    for(Contact c:Trigger.new){
    myfutureclasstrig.dotest(); //ob = new myfutureclasstrig();
    //ob.dotest();
    }
}