public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static Map <String, List<Object>>  getContacts(String accId, String relatedObjectNameParam, String value) {
        // Get readFieldSet
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(relatedObjectNameParam);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get('RelatedObjectOnAccount');
        List<Schema.FieldSetMember> readFieldSet = fieldSetObj.getFields(); 

        // Create a list of Objects to store value/lable/type of columns
        list <Object> objWrapper = new list <Object> ();
        for(Schema.FieldSetMember a: readFieldSet) {
            FetchValueWrapper fetchValueWrapper = new FetchValueWrapper();
            fetchValueWrapper.label = a.getLabel();
            fetchValueWrapper.fieldName = a.getFieldPath();
            fetchValueWrapper.editable = 'true';
            objWrapper.add(fetchValueWrapper);  
        }
        // Create a list of Objects to store actions of columns 
        FetchValueWrapper fetchValueActionsWrapper = new FetchValueWrapper();
        fetchValueActionsWrapper.type = 'action';        
        RowActions rowActionDelete = new RowActions('Delete','delete');
        RowActions rowActionRecordDetail = new RowActions('Record Details','record_details');
        RowActions rowActionEdit = new RowActions('Edit','edit');
        List<RowActions> list_ra = new List<RowActions>();
        list_ra.add(rowActionDelete);
        list_ra.add(rowActionRecordDetail);
        list_ra.add(rowActionEdit);
        TypeAttributes dtype = new TypeAttributes(list_ra);
        fetchValueActionsWrapper.typeAttributes = dtype;
        objWrapper.add(fetchValueActionsWrapper); 

        // Get data
        String query = 'SELECT ';
        for(Schema.FieldSetMember f : readFieldSet) {
            query += f.getFieldPath() + ', ';
        }
        query += 'Id FROM ';
        query += relatedObjectNameParam;
        query += ' WHERE AccountId = :accId';    
        query += ' LIMIT ';   
        query += value;        
        List<SObject> sobjectsList = (List<SObject>)Database.query(query);         
        // Create Map to store columns and list of data
        Map <String, List<Object>> resultMap = new Map <String, List<Object>> ();
        resultMap.put('sobjectsList', sobjectsList );
        resultMap.put('columnsLabel', objWrapper);
        return resultMap;
    }
    
    @AuraEnabled
    public static void deleteContacts(list<Id> lstConIds, String relatedObjectNameParam) {
        try {
            list<SObject> lstConsToDelete = new list<SObject>();
            for(Id idCon : lstConIds) {
                String query = 'SELECT ';
                query += 'Id FROM ';
                query += relatedObjectNameParam;
                query += ' WHERE Id =\''; 
                query += lstConIds[0];
                query += '\'';       
                List<SObject> sobjectsList = (List<SObject>)Database.query(query);     
                lstConsToDelete.addAll(sobjectsList);
            }
            if(!lstConsToDelete.isEmpty()) {
                delete lstConsToDelete;
            }
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    // Wrapper's classes for columns
    public with sharing class FetchValueWrapper {
        @auraEnabled public String label {get; set; }
        @auraEnabled public String fieldName {get; set; }
        @auraEnabled public String editable {get; set; }
        @auraEnabled public String type {get; set; }
        @auraEnabled public TypeAttributes typeAttributes {get; set; } 
    }

    public with sharing class RowActionsWrapper {
        @auraEnabled public String rowActions {get; set; }
        @auraEnabled public String menuAlignment {get; set; }
    }

        public with sharing class TypeAttributesWrapper {
        @auraEnabled public String type {get; set; }
        @auraEnabled public TypeAttributes typeAttributes {get; set; }
    }
       
    public with sharing class ActionsWrapper {
        @auraEnabled public String label {get; set; }
        @auraEnabled public String name {get; set; }
    }

    public class RowActions {
		 @AuraEnabled
         public String label {get; set; } 
		 @AuraEnabled
         public String name {get; set; } 
    public RowActions(String label, String name){
            this.label = label;
            this.name = name;
        }
    }
    
    public class TypeAttributes {
         @AuraEnabled
         public List<RowActions> rowActions {get; set; } 
        public TypeAttributes(List<RowActions> rowActions){
            this.rowActions = rowActions;
        }
    }
}
