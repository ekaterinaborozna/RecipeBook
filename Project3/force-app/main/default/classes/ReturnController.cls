public class ReturnController {

    public Integer valueReturned {get; set;}

    public ReturnController(){
        this.valueReturned = 0;
    }

    public void callMe(){
        this.valueReturned++;
    }

}