public class ComponentForCharityController {
    public Id cUserId {get; set;}
    
    public User getCurrentUser (){
        User currentUser = [SELECT Id, Name, Email FROM User WHERE Id =: cUserId];
        System.debug(currentUser);
        return currentUser;  
    }

}