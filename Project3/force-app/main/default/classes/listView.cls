public class listView {
    ApexPages.StandardSetController controller;
    public listView(ApexPages.StandardSetController controller) {
        this.controller = controller;
        controller.setPageSize(5);
    }
    public pageReference ShowAll() {
        controller.setPageSize(controller.getResultSize());
        return null;
    }
}