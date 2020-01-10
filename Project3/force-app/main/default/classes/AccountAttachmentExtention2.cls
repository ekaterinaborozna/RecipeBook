public class AccountAttachmentExtention2 {
    private ApexPages.StandardController sc;
    public Datetime serverTime {get; set;}
    public String systemTime {get; set;}
    public String userTime {get; set;}
    public Boolean hideInputButton {get; set;}
    public Boolean showBlockAfterSave {get; set;}
    public Boolean showTitle {get; set;}
    public String typeOfAccount {get; set;}
    public String attachmentTitle {get; set;}
    Transient Attachment file;
    public Map<Integer, Attachment> attachmentMap {get; set;}
    public Integer counter {get; set;}
    
    public AccountAttachmentExtention2(ApexPages.StandardController standardController) {  
        sc = standardController;  
        hideInputButton = true;
        showTitle = false;
        showBlockAfterSave = false; 
        attachmentMap = new Map<Integer, Attachment>();
        counter = 0;
        }
    
    public PageReference saveAccount() {
        sc.save();
        Account account = (Account)sc.getRecord();
        typeOfAccount = String.valueOf(account.Type);
        System.currentPageReference().getParameters().put('id', sc.getId()); 
        PageReference viewPage  = new PageReference(ApexPages.CurrentPage().GetURL());
        Id recordid = System.currentPageReference().getParameters().get('id');
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
        systemTime = dt.format('MM-dd-yy');
        //System time
        TimeZone tz = UserInfo.getTimeZone();
        userTime = dt.addSeconds((tz.getOffset(dt)/1000)).format('dd-MMMM-yyyy');
    }
    
    public Attachment getfile() {        
        file = new Attachment();
        return file;
    }
    
    public void collectAttach() {
        Id recordid = System.currentPageReference().getParameters().get('id');
        file.parentId = recordid;
        counter = counter +1;
        attachmentMap.put(counter, file);
        System.debug(attachmentMap);
        
    }
    
    public PageReference save() {
        
        try {insert attachmentMap.values();
             ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,'Attachment uploaded successfully.'));
             showTitle = true;
           /*  if (!attachmentTitle.endsWith('with')) {
                 attachmentTitle  += ', ';     
             }
             attachmentTitle += ' ' +attach.name ; */ 
            } catch (Exception e) {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + e.getMessage() + e.getStackTraceString());
                ApexPages.addMessage(myMsg);
            } 
        return null;
    }
    
    public void updatetime(){
    //Show server time
    serverTime = Datetime.now();
    }    
    
}