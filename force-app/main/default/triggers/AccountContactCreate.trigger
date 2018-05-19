trigger AccountContactCreate on Account (After insert,After update) {


if(trigger.isInsert)
{


    set<Id> acctids=Trigger.newmap.keyset();
    AccountUpdateBatchJob aubj=new AccountUpdateBatchJob(acctids);
    Database.executeBatch(aubj,1);
   
   }
   
   if(trigger.isupdate)
   {
   list<contact>lstctc=new list<contact>();
   list<Account> lstacc=[select id,(select id,phone from contacts),phone from account where id=:Trigger.newmap.keyset()];
   for(Account acc:lstacc)
   {
   for(contact c:acc.contacts)
   {
   c.phone=acc.phone;
   lstctc.add(c);
   
    }
    update lstctc;
}
}
}