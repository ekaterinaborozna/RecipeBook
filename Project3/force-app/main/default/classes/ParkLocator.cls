public class ParkLocator {
    public static String[] country(String ctry) {
        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
        return park.byCountry(ctry);
    }
}