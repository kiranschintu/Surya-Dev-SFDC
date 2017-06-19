trigger oppcontactonTask on Task (before update,before insert) {
    for(Task tak :Trigger.new){
        tak.description ='sfdsf';
        tak.WhoId ='0039000000Q51yK';
    }
}