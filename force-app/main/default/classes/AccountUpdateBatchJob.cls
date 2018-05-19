global class AccountUpdateBatchJob implements Database.Batchable<sObject>
{

    global set<id> acctids;
    
    global AccountUpdateBatchJob(set<Id> acctids){
    
      this.acctids=acctids;
    
    
    }
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'select id from account limit 1';
       
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC,list<Account> scope)
    {
        list<id> lstacct=new list<id>();
        lstacct.addall(acctids);
    
    
      list<contact> ctclist=new list<contact>();
     for(integer i=0; i<152;i++){
       contact c=new contact();
        c.firstname='testctc'+i;
        c.lastname='lasttest';
        c.accountid=lstacct[0];
        ctclist.add(c);
        //insert c;
     
     }
     insert ctclist;
    }
    global void finish(Database.BatchableContext BC) {
    }
}