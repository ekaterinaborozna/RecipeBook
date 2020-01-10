global class NameContactSheduler implements Schedulable {
    //15 числа каждого месяца в 12:00
    public static String CRON_EXP = '0 0 12 15 * ?';
    
    global void execute(SchedulableContext ctx) {
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :ctx.getTriggerId()];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
        firstNameContactQueueable();
    }     
    public void firstNameContactQueueable() {
        System.enqueueJob(new FirstNameContactQueueable());
    }
}