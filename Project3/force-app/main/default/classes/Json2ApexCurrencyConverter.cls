public class Json2ApexCurrencyConverter {

	public Integer Cur_ID;
	public String DateX;
	public String Cur_Abbreviation;
	public Integer Cur_Scale;
	public String Cur_Name;
	public Double Cur_OfficialRate;

	
	public static List<Json2ApexCurrencyConverter> parse(String json) {
		return (List<Json2ApexCurrencyConverter>) System.JSON.deserialize(json, List<Json2ApexCurrencyConverter>.class);
	}
}