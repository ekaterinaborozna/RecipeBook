global with sharing class ContactLocationMapExtension {
    public ApexPages.StandardSetController ssc {get; set;}  
    public List<Contact> contactsList {get; set;}
    public Integer rowsOnPage {get; set;}
    public Integer numRecords {get; set;}
    public String chosenSize {get; set;}
    public String sortBy {get; set;} 
    public String sortDirect {get; set;}
    public String filterByField {get; set;}  
    public String sortByField {get; set;} 
    public String textSearch {get; set;} 
    
    public contactLocationMapExtension(ApexPages.StandardSetController standardController) {  
        ssc = standardController;  
        applyFilter(); 
        sortBy = 'Title';
    } 
    
    public void sortData() {        
        if (sortDirect == 'ASC') {
            sortDirect = 'DESC';
        } else {
            sortDirect = 'ASC';
        }
        applyFilter();
    }
    
    public PageReference applyFilter() { 
        String query = 'SELECT LastName, FirstName, Title, Accountid, location__longitude__s, location__latitude__s FROM Contact ';
        String orderBy = '';
        String searchQuery = '';
        if (sortByField != null
            && sortDirect != '') {
                orderBy = ' ORDER BY ' + sortByField + ' ' + sortDirect;
            }  
        if (filterByField != null 
            && textSearch != null
            && textSearch != '' ) {
                searchQuery = ' WHERE ' + filterByField + ' LIKE \'' + textSearch + '%\' ';
            }
        query +=  searchQuery + orderBy + ' LIMIT 100';
        ssc = new ApexPages.StandardSetController(Database.Query(query));
        //Set page size
        if(chosenSize != null) {
            ssc.setPageSize(Integer.valueOf(chosenSize));
        } else {
            ssc.setPageSize(5);
        }
        
        if (ssc.getRecords().size() == 0) {        
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Info, 'No matching Contacts found.'));   
        }
        //Get page count data
        numRecords = Integer.valueOf(ssc.getResultSize());         
        if (chosenSize != null) {
            rowsOnPage = Integer.valueOf(chosenSize);   
        } else {
            rowsOnPage = 5; 
        } 
        return null; 
    }   
    
    public Map<Id, ContactWrapper> getContactWrappersMap() {
        Map<Id, ContactWrapper> ContactWrappersMap = new Map<Id, ContactWrapper>();   
        contactsList = (List<Contact>)ssc.getRecords();  
        for (Contact contact : contactsList) {
            ContactWrapper ContactWrap = new ContactWrapper();
            ContactWrap.contactInWrapper = contact;
            ContactWrap.fieldSortBy = String.valueOf(contact.get(sortBy));
            ContactWrappersMap.put(ContactWrap.contactInWrapper.Id, ContactWrap); 
        }
        return ContactWrappersMap;
    }
    
    public void resetFunction() {
        sortByField = null;
        sortDirect = null;
        filterByField = null;
        textSearch = null;
        applyFilter();
    }
    
    public class ContactWrapper implements Comparable { 
        public Contact contactInWrapper {get; set;}
        public String fieldSortBy {get; set;}        
        public integer compareTo(Object compareTo) {
            ContactWrapper wrapperCompareTo = (ContactWrapper)compareTo;
            if (fieldSortBy == wrapperCompareTo.fieldSortBy) {
                return 0;
            } else if (fieldSortBy > wrapperCompareTo.fieldSortBy) {
                return -1;
            } else {
                return 1;
            }
        }
    }
    
    public List<ContactWrapper> getContacts() { 
        List<ContactWrapper> contacts = getContactWrappersMap().values();
        contacts.sort();
        return contacts;
    }
    
    public List<SelectOption> getContactFields() {
        List<SelectOption> contactFields = new List<SelectOption> { 
            new SelectOption('Title', 'Title'), 
            new SelectOption('FirstName', 'FirstName'), 
            new SelectOption('LastName', 'LastName'),
            new SelectOption('AccountId', 'AccountId')
        };
        return contactFields;
    } 
    
    public List<SelectOption> getItemsValues() {
        List<SelectOption> itemsValues = new List<SelectOption> { 
            new SelectOption('5', '5'), 
            new SelectOption('10', '10'), 
            new SelectOption('15', '15'),
            new SelectOption('20', '20')
        };
        return itemsValues;
    } 
    
    public List<SelectOption> getFilterFields() {        
        List<SelectOption> filterFields = new List<SelectOption> { 
            new SelectOption('Title', 'Title'), 
            new SelectOption('FirstName', 'FirstName'), 
            new SelectOption('LastName', 'LastName'),
            new SelectOption('AccountId', 'AccountId')
         };
        return filterFields;
    }  
    
    @RemoteAction 
    global static String getAdress(String selectedContactId) {
        Contact selectedContact = [SELECT Id, MailingState, MailingCountry, MailingCity, MailingStreet FROM Contact WHERE Id=: selectedContactId LIMIT 1];
        String adress = ''; 
        String mailingCity = selectedContact.MailingCity; 
        String mailingCountry = selectedContact.MailingCountry;
        if (mailingCountry != null) {
            adress += mailingCountry;     
        }
        if (mailingCity != null && mailingCountry != null) {
            adress += ', ' + mailingCity;     
        } 
        if (mailingCity != null && mailingCountry == null) {
            adress += mailingCity;     
        } 
        if (mailingCity == null && mailingCountry == null) {
            adress += 'not found.';      
        }
        return adress;
    }
}