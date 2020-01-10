global class CreateOrderScheduler implements Schedulable {
    // hourly
    public static String CRON_EXP = '0 0 * * * ?';
    
    global void execute (SchedulableContext ctx) {
        // Get cron trigger
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :ctx.getTriggerId()];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        createOrders();
    }     
    public void createOrders() {
        CreateOrderBatch myBatch = new CreateOrderBatch();
        Database.executeBatch(myBatch);
    }
}