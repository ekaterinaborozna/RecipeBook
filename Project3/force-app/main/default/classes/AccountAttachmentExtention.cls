public class AccountAttachmentExtention {
    private ApexPages.StandardController sc;
    public Datetime serverTime {get; set;}
    public String SystemTime {get; set;}
    public String UserTime {get; set;}
    public Boolean hideInputButton {get; set;}
    public Boolean showBlockAfterSave {get; set;}
    public Boolean showTitle {get; set;}
    public String typeOfAccount {get; set;}
    public String attachmentTitle {get; set;}
    Transient Attachment file;
    
    public AccountAttachmentExtention(ApexPages.StandardController standardController) {  
        sc = standardController;  
        hideInputButton = true;
        showTitle = false;
        showBlockAfterSave = false;  
    }
    
    public PageReference saveAccount() {
        sc.save();
        Account account = (Account)sc.getRecord();
        typeOfAccount = String.valueOf(account.Type);
        System.currentPageReference().getParameters().put('id', sc.getId()); 
        PageReference viewPage  = new PageReference(ApexPages.CurrentPage().GetURL());
        String recordid = System.currentPageReference().getParameters().get('id');
        showTime();
        showBlockAfterSave = true;
        attachmentTitle = 'Account ' + account.Name + ' with'; 
        return viewPage;
    }
    
    public void showHideInput () {
        if (hideInputButton != true) {
            hideInputButton = true;              
        } else {
            hideInputButton = false;    
        }
    }    
    
    public void showTime() {
        //Current Datetime in the local time zone  
        DateTime dt = Datetime.now();
        SystemTime = dt.format('MM-dd-yy');
        //System time
        TimeZone tz = UserInfo.getTimeZone();
        UserTime = dt.addSeconds((tz.getOffset(dt)/1000)).format('dd-MMMM-yyyy');
    }
    
    public Attachment getfile() {        
        file = new Attachment();
        return file;
    }
    
    
    public PageReference save() {
        String recordid = System.currentPageReference().getParameters().get('id');
        Attachment attach = new Attachment(
            parentid = recordid,
            name = file.name,
            body = file.body);
        try {
            insert attach;
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Attachment uploaded successfully.'));
            showTitle = true;
            if (!attachmentTitle.endsWith('with')) {
                attachmentTitle  += ', ';     
            }
            attachmentTitle += ' ' +attach.name ;  
        } catch (Exception e) {
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage() + e.getStackTraceString());
            ApexPages.addMessage(myMsg);
        } 
        return null;
    }
    
    public void updatetime() {
        //Show server time
        serverTime = Datetime.now();
    }    
    
}