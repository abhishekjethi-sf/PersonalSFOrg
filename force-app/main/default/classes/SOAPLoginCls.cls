/*
	SOAP class for login to SFDC and get the session Id
*/
public class SOAPLoginCls {
	
	// Get Session Id using Custom Metadata Type
	public static String getSessionId(){
		
		/*String username = 'nikitas0413@gmail.com';
		String password = 'Test@1234';
		String NS_SOAP = 'http://schemas.xmlsoap.org/soap/envelope/';
		String NS_SF = 'urn:partner.soap.sforce.com';
		*/
		IntegrationDetails__mdt nikkiOrg = [SELECT Username__c,Password__c,NS_SOAP__c,NS_SF__c FROM IntegrationDetails__mdt WHERE DeveloperName = 'NikitaOrg' LIMIT 1];
		
		HttpRequest req = new HttpRequest();
		req.setMethod('POST');   
		req.setEndpoint('https://ap5.salesforce.com/services/Soap/u/43.0');
		req.setHeader('Content-Type', 'text/xml;charset=UTF-8');
		req.setHeader('SOAPAction', 'create');
		req.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' + nikkiOrg.Username__c + '</username><password>' + nikkiOrg.Password__c + '</password></login></Body></Envelope>');
		
		HttpResponse res =  new Http().send(req);
		Dom.Document responseDocument = res.getBodyDocument();
		Dom.Xmlnode rootElm = responseDocument.getRootElement(); // soapenv:Envelope
		Dom.Xmlnode bodyElm = rootElm.getChildElement('Body', nikkiOrg.NS_SOAP__c); // soapenv:Body 
		Dom.Xmlnode loginResponseElm = bodyElm.getChildElement('loginResponse', nikkiOrg.NS_SF__c); // loginResponse
		Dom.Xmlnode resultElm = loginResponseElm.getChildElement('result', nikkiOrg.NS_SF__c); // result
		Dom.Xmlnode sessionIdElm = resultElm.getChildElement('sessionId', nikkiOrg.NS_SF__c); // sessionId
		String SERVER_URL = resultElm.getChildElement('serverUrl', 'urn:partner.soap.sforce.com') .getText().split('/services')[0];
		String SESSION_ID = resultElm.getChildElement('sessionId', 'urn:partner.soap.sforce.com') .getText();
		system.debug('#########SESSION_ID########'+SESSION_ID);
		return SESSION_ID;
	}
    
}