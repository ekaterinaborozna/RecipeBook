public class ExampleExtension {
    public String text {get; set;}
    private ApexPages.StandardController sc;
    
    public ExampleExtension(ApexPages.StandardController standardController){
        sc = standardController;
        text='Click';
    }
    
    
    public void methodOne(){
        text='clickedmethodOne!!!';
    }
    public void updatetime(){
        text='method updateTimeInCntr!!!';
    }
}