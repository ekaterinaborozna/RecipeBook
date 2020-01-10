public class hExtention {
    private ApexPages.StandardController sc;
    public List<Attachment> attachmentList {get; set;}
    
    public hExtention(ApexPages.StandardController standardController) {  
        sc = standardController;
        }
    
        Transient Attachment file;
    public Attachment getfile() {        
        file = new Attachment();
        return file;
    }
    public void collectAttach() {
    System.debug('jjjjj');
    }

}