trigger emailMessageTrigger on EmailMessage (before Insert) {
    if(Trigger.isBefore && Trigger.isInsert)
    {
        EmailMessageTriggerHandler.setThreadIdforServiceRequest(Trigger.new);
    }

}