trigger dotask on Account (after insert,after update) {

for(Account acc:trigger.new){
acc.description= 'Welcome';

}
}