/**
*@purpose : Apex Controller responsible for Entry of Customer Records
*@author :  Souvik 
**/
public with sharing  class CustomerEntryPageController {
    public Customer__c customerObj{get;set;}
    public Id customerId {get;set;}
    public String message{get;set;}
 
    /**
    *@purpose : Constructor to fetch current Customer Record and its Action
    **/
   public CustomerEntryPageController () { 
      message = '';
      // Fetching the Current Customer Id
      customerId = System.currentPageReference().getParameters().get('Id');
       if(customerId != NULL){
         customerObj = [SELECT Id,Name FROM Customer__c WHERE id=:customerId];
      }
   }
 
   /**
    *@purpose : Method for Saving the Customer Object Record 
    *@param : None 
    *@return : PageReference to Standard Salesforce Record Detail Page 
    **/
   public PageReference savingCustomerRecord(){
      try{
         upsert customerObj;
         PageReference nextpage= new PageReference('/'+customerObj.id);
           return nextpage;
      }
      catch(Exception e){
            message='Data Base error during saving...';
            ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.ERROR, message));
            return null;
        }
   }
}