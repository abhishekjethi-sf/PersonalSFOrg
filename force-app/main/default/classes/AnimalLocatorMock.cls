@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
	
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}');
        response.setStatusCode(200);
        return response; 
    }	
    
    /*
    
    @isTest
    global class AnimalCalloutMock implements HttpCalloutMock{
    
    	global HttpResponse respond(HttpRequest request){
    		HttpResponse response = new HttpResponse();
    		response.setHeader(2)
			
			return response;    	
    	}
    }

	String s = '{"totalResults": 2, "startIndex":0, "pricing":[{"price":10.80,"cost":9.22,"gp":12},{"price":5.50,"cost":4.00,"gp":24}]}';
	Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(s);
	System.debug('>dgfdfg>> ' + m);
	List<Object> pricing = (List<Object>) m.get('pricing');
	System.debug('>dfgfdgfdgfdg>> ' + pricing);
	for (Object o : pricing) {
	    Map<String, Object> p = (Map<String, Object>) o;
	    System.debug('>df434>> ' + p);
	}    
    
    */
}