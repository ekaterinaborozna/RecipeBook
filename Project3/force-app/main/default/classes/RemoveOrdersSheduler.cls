global class RemoveOrdersSheduler implements Schedulable {
    //Every day at 6am
    public static String CRON_EXP = '0 0 6 * * ?';
    
    global void execute(SchedulableContext ctx) {
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :ctx.getTriggerId()];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        removeOrders();
    }     
    public void removeOrders() {
        RemoveOrdersBatch myBatch = new RemoveOrdersBatch ();
        Database.executeBatch(myBatch, 100);
    }
}