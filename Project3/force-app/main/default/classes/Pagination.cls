public class Pagination {
 
    public Pagination(ApexPages.StandardSetController controller) {
        controller.setPageSize(10);
    }
 
}