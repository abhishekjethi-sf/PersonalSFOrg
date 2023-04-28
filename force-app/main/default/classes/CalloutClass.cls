public class CalloutClass {
	
    @future(callout=true)
    public static void makeCallout() {
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        // Set the endpoint URL.
        String endpoint = 'http://yourHost/yourService';
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        HttpResponse response = http.send(request);
    }
}