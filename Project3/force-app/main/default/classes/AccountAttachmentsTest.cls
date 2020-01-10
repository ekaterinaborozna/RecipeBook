@isTest 
public class AccountAttachmentsTest {
    @isTest static  void positiveTest() {
        Account account = new Account(Name = 'TestAccount');        
        PageReference pageRef = Page.AccountAttachments;
        Test.setCurrentPageReference(pageRef);

        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(account);
        AccountAttachmentExtention contrClass = new AccountAttachmentExtention(stdController); 
        contrClass.saveAccount();
        contrClass.showHideInput();
        contrClass.updatetime();
        Test.stopTest();
        
        List<Account> accountList = [SELECT Id, Name FROM Account WHERE Name = 'TestAccount'];
       
        System.assertEquals(1, accountList.size());
        System.assertEquals(false, contrClass.hideInputButton);
    }
    
   @isTest static  void negativeAttachmentTest() {
        Account account = new Account(Name = 'TestAccount');       
        PageReference pageRef = Page.AccountAttachments;
        Test.setCurrentPageReference(pageRef);   

        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(account);
        AccountAttachmentExtention contrClass = new AccountAttachmentExtention(stdController); 
        contrClass.saveAccount();
        contrClass.hideInputButton = false;   
        contrClass.showHideInput();    
        //Attachment attach=new Attachment(); 
        contrClass.getfile();
        contrClass.save();
        Test.stopTest();
        
        List<Account> accountList = [SELECT Id, Name FROM Account WHERE Name = 'TestAccount'];
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        //Required fields are missing: [Name, Body]
        for (Apexpages.Message msg : msgs) {
            if (msg.getDetail().contains('Error: Insert failed.')) {
                b = true;  
            } 
        }
        
        System.assert(b);
        System.assertEquals(1, accountList.size());
        System.assertEquals(true, contrClass.hideInputButton);
    }
    
    @isTest static  void positiveAttachmentTest() {
        Account account = new Account(Name = 'TestAccount');       
        PageReference pageRef = Page.AccountAttachments;
        Test.setCurrentPageReference(pageRef);   

        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(account);
        AccountAttachmentExtention contrClass = new AccountAttachmentExtention(stdController); 
        contrClass.saveAccount(); 
        Transient Attachment file = contrClass.getfile(); 
        file.Name = 'Name';
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        file.Body = bodyBlob;
        contrClass.save();
        Test.stopTest();
        
        List<Account> accountList = [SELECT Id, Name FROM Account WHERE Name = 'TestAccount'];
        List<Attachment> attachmentList = [SELECT ID, Name FROM Attachment WHERE ParentId = :accountList[0].Id];
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for (Apexpages.Message msg : msgs) {
            if (msg.getDetail().contains('Attachment uploaded successfully.')) {
                b = true;  
            } 
        }
        
        System.assertEquals(1, accountList.size());
        System.assertEquals(1, attachmentList.size());
        System.assert(b);
    }
    
     @isTest static  void positiveAttachmentsTest() {
        Account account = new Account(Name = 'TestAccount');       
        PageReference pageRef = Page.AccountAttachments;
        Test.setCurrentPageReference(pageRef);   

        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(account);
        AccountAttachmentExtention contrClass = new AccountAttachmentExtention(stdController); 
        contrClass.saveAccount(); 
        //1 Attachment 
        Transient Attachment file = contrClass.getfile(); 
        file.Name = 'Name';
        Blob bodyBlob = Blob.valueOf('Unit Test Attachment Body');
        file.Body = bodyBlob;
        contrClass.save();
        //2 Attachment
        Transient Attachment file2 = contrClass.getfile(); 
        file2.Name = 'Name';
        Blob bodyBlob2 = Blob.valueOf('Unit Test Attachment Body');
        file2.Body = bodyBlob;
        contrClass.save();
        Test.stopTest();
        
        List<Account> accountList = [SELECT Id, Name FROM Account WHERE Name = 'TestAccount'];
        List<Attachment> attachmentList = [SELECT ID, Name FROM Attachment WHERE ParentId = :accountList[0].Id];
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for (Apexpages.Message msg : msgs) {
            if (msg.getDetail().contains('Attachment uploaded successfully.')) {
                b = true;  
            } 
        }
        
        System.assertEquals(1, accountList.size());
        System.assertEquals(2, attachmentList.size());
        System.assert(b);
        System.assert(contrClass.attachmentTitle.contains(','));
    }
}