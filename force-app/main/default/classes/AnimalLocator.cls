public class AnimalLocator {
	
	public static String getAnimalNameById(Integer position){
		
		String animalName = '';
		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setMethod('GET');
		request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+String.valueof(position));
		HttpResponse response = http.send(request);
		
		system.debug('#####responseBody#####'+response);
		system.debug('#####responseBody#####'+response.getBody());
		
		if(response.getStatusCode() == 200){
	        // Deserializes the JSON string into collections of primitive data types.
	        map<String, Object> results = (map<String, Object>) JSON.deserializeUntyped(response.getBody());
			system.debug('#####results#####'+results);
			
			map<String, Object> animal = (map<String, Object>) results.get('animal');
			system.debug('#####animal#####'+animal);
			animalName =  (String)animal.get('name');
		}
		return animalName;
	}
		/*
		String dummyJSON = '';
		dummyJSON += ' {												'+  
					 ' 	   "animal":{  									'+
					 '	      "id":2,									'+
					 '	      "name":"bear",							'+
					 '	      "eats":"berries, campers, adam seligman",	'+
					 '	      "says":"yum yum"							'+
					 '	   }											'+
					 '	}												';
					 
			Integer position = 2;
			Http http = new Http();
			HttpRequest request = new HttpRequest();
			request.setMethod('GET');
			request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+String.valueof(position));
			HttpResponse response = http.send(request);
			system.debug('#####responseBody#####'+response);
			system.debug('#####responseBody#####'+response.getBody());							 
		*/			 
}