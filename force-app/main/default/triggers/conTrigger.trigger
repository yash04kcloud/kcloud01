trigger conTrigger on Contact (after insert , after update, after delete) {

    Set<Id> accountIdSet = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate) {
        for(Contact con : trigger.new) {
            accountIdSet.add(con.AccountId);
        }
    }
    
    if(Trigger.isUpdate) {
        for(Contact con : trigger.old) {
            accountIdSet.add(con.AccountId);
        }
    }
    //hiii
    if(Trigger.isDelete) {
        for(Contact con : trigger.old) {
            accountIdSet.add(con.AccountId);
        }
    }
    //hiiii
    List<Account> accountList = [SELECT Id,Name,NumberofEmployees,(SELECT Id,AccountId FROM Contacts) 
                                 FROM Account WHERE ID IN: accountIdSet];
    
    for(Account acc : accountList) {
        acc.NumberofEmployees = acc.contacts.size();
    }
    
    update accountList;
    
}