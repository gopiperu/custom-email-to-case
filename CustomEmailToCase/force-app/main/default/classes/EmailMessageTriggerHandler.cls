public with sharing class EmailMessageTriggerHandler {
    public EmailMessageTriggerHandler() {

    }

    public static void setThreadIdforServiceRequest(List<EmailMessage> emailMessageLst)
    {
        Set<Id> srIdSet = New Set<Id>();
        Map<Id,String> srIdThreadIdMap = New Map<Id,String>();
        for(EmailMessage emailMessageItem : emailMessageLst)
        {
           if(emailMessageItem.RelatedToId.getSObjectType().getDescribe().getName() == 'Service_Request__c')
            {
                srIdSet.add(emailMessageItem.RelatedToId);
            }
        }

        if(!srIdSet.isEmpty()) 
        {
            for(Service_Request__c srItem : [SELECT Id, Email_Thread_Id__c 
                                        FROM Service_Request__c 
                                        WHERE Id 
                                        IN :srIdSet])
            {
                srIdThreadIdMap.put(srItem.Id,srItem.Email_Thread_Id__c);
            }
        }
        

        for(EmailMessage emailMessageItem : emailMessageLst)
        {
            if(srIdThreadIdMap.containsKey(emailMessageItem.RelatedToId))
            {
                emailMessageItem.subject =  emailMessageItem.subject + '-' +srIdThreadIdMap.get(emailMessageItem.RelatedToId);
            }
        }
    }
}
