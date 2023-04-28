public class ParkLocator {
	
	public static list<String> country(String countryName){
		ParkService.ParksImplPort parksList = new ParkService.ParksImplPort();
		return parksList.byCountry(countryName);
	}
    
}