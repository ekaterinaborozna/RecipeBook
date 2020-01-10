global with sharing class ContactJs {  
   
    public ContactJs() { } // empty constructor    
 
 /*   @RemoteAction 
    global static Contact getcon() {
        Contact con1 = [SELECT id,name FROM contact limit 1];
        if(con1!=null ){        
            return con1;        
        }else{        
            return  new contact();        
        }
    } */
    
        @RemoteAction 
    global static Contact getcon() {
        //function should be static and global else it will throw error
        Contact selectedContact = [SELECT Id, Name, Location__longitude__s, Location__latitude__s  FROM contact WHERE Id= '0032v00002rSyYwAAK' limit 1];
        if (selectedContact != null) {  
            return selectedContact;        
        } else {        
            return new Contact();        
        }
    }
}