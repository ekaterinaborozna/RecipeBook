public with sharing class ContactData {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId) {
        return [SELECT Id, Name ,Email, Phone from Contact where AccountId = :accId];
    }
}