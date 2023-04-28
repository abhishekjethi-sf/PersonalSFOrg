public class JWTIntegration {

    public static void wooliesAPIIntegration(){
    	/*  
    	 	RSA_HTTPCalloutService - This class is used as a common class for Integration to MasterDB
		public class RSA_HTTPCalloutService{
           //This method forms and returns the HTTP Request 
      
            public static RSA_HTTPCalloutUtility.requestWrapper getRequest(Rew_HTTPCalloutWrapper objwrap) {
                RSA_HTTPCalloutUtility objCalloutUtility = new RSA_HTTPCalloutUtility();
                return objCalloutUtility.commonCalloutMethod(objwrap);
            }
        
           // This method is used to send HTTP Request received in parameter and return the response
            public static ResponseWrapper sendRequest(Rew_HTTPCalloutWrapper objwrap) {
                
                RSA_HTTPCalloutUtility.requestWrapper requestWrap = getRequest(objwrap) ;
                HTTPRequest request = requestWrap.httpreq;
                Http http = new Http();
                Boolean insertToken = FALSE ;
                HTTPResponse response = new HTTPResponse();
                response = http.send(request);
                System.debug('response::'+response);
                
                if(requestWrap.isInsertAuth && objwrap.isSkipAuth != TRUE)
                {
                    upsert requestWrap.authRecord;
                }
                else if(requestWrap.isInsertAuth && objwrap.isSkipAuth == TRUE){
                    insertToken = TRUE ;
                }
        
                return new ResponseWrapper(response,requestWrap.authRecord,insertToken);
            }
        
            public class ResponseWrapper{
                public HttpResponse respData;
                public Rew_Authorization_Token__c authRecord ;
                public Boolean isInsertAuth ;
                ResponseWrapper(HttpResponse resp, Rew_Authorization_Token__c authObj,Boolean updateToken)
                {    
                    respData = resp;
                    authRecord = authObj ;
                    isInsertAuth = updateToken;
                }
            }
            }
		*/
        
        /*
         	RSA_HTTPCalloutUtility - This class is used as a common class for Integration to MasterDB

			public class RSA_HTTPCalloutUtility {
                Map<String, String> headerParametersMap;
                RSA_Global_Settings__c globalSetting = RSA_Global_Settings__c.getInstance();
                HTTPRequest request;
                String requestBody;
                String accessToken;
                Rew_Authorization_Token__c authRecord = new Rew_Authorization_Token__c();
                Boolean updateToken ;
                String EndPointUrl ;
                String random ;
                public RSA_HTTPCalloutUtility()
                {
                    String headerJson = globalSetting.RSA_Headers__c;
                    headerParametersMap = (Map<String,String>) JSON.deserialize(headerJson, Map<String,String>.class);
                    Integer randomNumber = Integer.valueof((Math.random() * 5));
                    random = String.valueof(randomNumber) ;
                    random = '1';
                    System.debug('randomNumber  is'+random);
                    
                }
    
                public Static String generateJWTToken(String userName,String userRole,String random)
                {
                    String strJWT = '';
                    userRole ='Rewards CHM';
                    random ='1';
                    JSONGenerator header = JSON.createGenerator(false);	
                    header.writeStartObject();
                    header.writeStringField('alg', 'RS256');
                    header.writeStringField('typ', 'JWT');
                    header.writeEndObject();
                    //Encode the header	
                    String encodedHeader = base64URLencode(Blob.valueOf(header.getAsString()));
                    System.debug('Username::'+userName + 'UserRole::'+userRole);
                    //create request body or claims body
                    JSONGenerator body = JSON.createGenerator(false);
                    body.writeStartObject();
                    //body.writeStringField('iss','Salesforce-CustomerHub'); // static value
                    //body.writeStringField('sub', 'Xact'); //static value
                    //body.writeStringField('aud', 'https://api.woolworthsrewards.com.au'); //static value
                    body.writeStringField('userid',userName); //logged in username would be passed
                    body.writeStringField('userroles',userRole); //logged in user role would be passed
                    
                    //set current and expired datetime stamp
                    long currenttime = (dateTime.now().getTime()/1000);
                    body.writeNumberField('iat', currenttime);
                    //body.writeNumberField('exp', (dateTime.now().addminutes(10).getTime()/1000)); // add 5 min in expiry
                    body.writeEndObject();
                    System.debug('iat::'+currenttime);
                    System.debug('exp::'+(dateTime.now().addminutes(10).getTime()/1000));
                    //Encode the request body string
                    strJWT = encodedHeader + '.' + base64URLencode(Blob.valueOf(body.getAsString()));
                    
                    //To get the private key first need to generate the random numbers between 1 to 5
                    string privatekey = '';
                    //use this random number to get the data from custom metadata
                    Rew_JWTKeys__mdt objkeysMtdt = [SELECT Rew_Public_Key__c,
                                                    Rew_Private_Key__c,MasterLabel 
                                                    FROM Rew_JWTKeys__mdt 
                                                    WHERE MasterLabel =: random];
                    System.debug('Rew_JWTKeys__mdt::'+objkeysMtdt);
                    
                    if(objkeysMtdt.Rew_Private_Key__c != NULL){
                        privatekey = objkeysMtdt.Rew_Private_Key__c;
                    }
                    
                    //Sign the header and body with private key by using RSA-256 algo
                    Blob signature = null;
                    Blob key= EncodingUtil.base64Decode(privatekey);
                    signature = Crypto.sign('rsa-sha256', Blob.valueOf(strJWT ), key);
                    strJWT += '.' + base64URLencode(signature); 
                    system.debug('strJWT ======'+strJWT );
                    
                    return strJWT ;
                }
                
                //below method encode the data by base 64
                public Static String base64URLencode(Blob input){ 
                    String output = encodingUtil.base64Encode(input);
                    output = output.replace('+', '-');
                    output = output.replace('/', '_');
                    while ( output.endsWith('=')){
                        output = output.subString(0,output.length()-1);
                    }
                    return output;
                }	
                

    // This method is used to set Header parameters using headerParametersMap
    private void addHeaderParameters() {
            System.debug('request Headers::');
            for(String key : headerParametersMap.keySet()) {
                request.setHeader(key, headerParametersMap.get(key));
                System.debug(key+':'+headerParametersMap.get(key));
            }
            System.debug('--------------');
    }
    
   
		//This method is used to fetchAccessTocken
	    public void fetchAccessToken(String userName,String userRole)
    {
        List<Rew_Authorization_Token__c> listAuthorizationToken = new List<Rew_Authorization_Token__c>();
        
        ///String userName = System.label.rew_AccessTockenUserDetailsTest.split(',')[0];
        //String userRole = '';
        //String userName = UserInfo.getUserName();
        DateTime currentTime = system.now();
        
        listAuthorizationToken = [SELECT Id,Name,Rew_Expires_In__c,Rew_Token__c,Rew_Token_Expire_Time__c
                                  FROM Rew_Authorization_Token__c WHERE Name =: userName limit 1];
        
        if(!listAuthorizationToken.isEmpty())
        {
            if(currentTime < listAuthorizationToken[0].Rew_Token_Expire_Time__c)
            {
                accessToken = listAuthorizationToken[0].Rew_Token__c;
                updateToken = FALSE ;
            }
            else 
            {
                Map<String,Object> responseMap =new Map<String,Object>();
                //responseMap = generateAccessToken(userName);
                responseMap = getAccessToken(userName,userRole);
                accessToken = String.valueof(responseMap.get('access_token'));
                
                authRecord = updateAccessToken(userName,Integer.valueof(responseMap.get('expires_in')),String.valueof(responseMap.get('access_token')),listAuthorizationToken[0].Id);
                updateToken = TRUE ;
            }
        }
        else 
        {
            Map<String,Object> responseMap =new Map<String,Object>();
            
            //responseMap = generateAccessToken(userName);
            responseMap = getAccessToken(userName,userRole);
            accessToken = String.valueof(responseMap.get('access_token'));
            authRecord = updateAccessToken(userName,Integer.valueof(responseMap.get('expires_in')),String.valueof(responseMap.get('access_token')),null);
            updateToken = TRUE ;
        }
    }
    
    public static Rew_Authorization_Token__c updateAccessToken(String UserName,Integer Expires_In,String AccessToken, Id RecordId)
    {
        Rew_Authorization_Token__c objAuthorization = new Rew_Authorization_Token__c(Name = UserName,Rew_Expires_In__c = Expires_In,Rew_Token__c = AccessToken,Rew_Token_Expire_Time__c = system.now().addSeconds(Expires_In));
        if(!String.isblank(RecordId))
        {
            objAuthorization.Id = RecordId;
        }
        return objAuthorization;
    } 
    
    
 		//This method is used to generate Access Tocken via api callout
    	public Map<String,Object> getAccessToken(String userName,String userRole)
   		 {
        String jwtToken = generateJWTToken(userName,userRole,random); 
        headerParametersMap.remove('Authorization');
        Map<String, string> mapReqBody = new Map<String, string>();
        RSA_EndPoint_URL__c apiSetting = RSA_EndPoint_URL__c.getInstance('JWT Authentication API');
        
        mapReqBody.put('jwt',jwtToken);
        requestBody = JSON.Serialize(mapReqBody);
        Map<String, string> mapReqHeader = new Map<String, string>();
        mapReqHeader.put('rsa-key',random);
        headerParametersMap.put('rsa-key', random);
        System.debug('headerParametersMap::'+headerParametersMap);
        EndPointUrl = apiSetting.RSA_EndPoint_URL__c ;
        formHTTPRequest(apiSetting);
        Http http = new Http();
        request.setHeader('Accept','application/json');
        HTTPResponse response = http.send(request);
        Map<String,Object> responseMap = new Map<String,Object>();
        responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Map<String,Object> mapData = new Map<String,Object>();
        
        if(!responseMap.isEmpty()){
            Object accessTokenObj = responseMap;
            mapData = (Map<String,Object>)accessTokenObj;
        }
        
        //System.debug('response::'+resp);
        System.debug('response::'+mapData);
        return mapData;
    }
    
    
    public requestWrapper commonCalloutMethod(Rew_HTTPCalloutWrapper calloutWrapper)
    { system.debug('Hi');
     String userName = UserInfo.getUserName();
     String userRole ;
     if(!String.isBlank(calloutWrapper.userName)){
         userName = calloutWrapper.userName;
     }
     if(!String.isBlank(calloutWrapper.userRole)){
         userRole = calloutWrapper.userRole ;
     }else{
         User rec = [SELECT Id,UserRole.Name FROM User WHERE username =: userName ];
         userRole = rec.UserRole.Name ;
     }
     userRole = 'Rewards CHM';
     fetchAccessToken(userName,userRole);
     String customSettingInstance ;
     
     if(!String.isblank(calloutWrapper.parameterName))
     {
         customSettingInstance = calloutWrapper.serviceName +' '+ calloutWrapper.parameterName ;
     }
     else
     {
         customSettingInstance = calloutWrapper.serviceName ;
     }
     if(!String.isblank(calloutWrapper.additionHeader))
     {
         headerParametersMap.putAll((Map<String,String>) JSON.deserialize(calloutWrapper.additionHeader, Map<String,String>.class));
     }
     
     //List<RSA_EndPoint_URL__c> mcs = RSA_EndPoint_URL__c.getall().values();
     RSA_EndPoint_URL__c apiSetting = RSA_EndPoint_URL__c.getInstance(customSettingInstance); 
     requestBody = calloutWrapper.requestBody;
     
     EndPointUrl = apiSetting.RSA_EndPoint_URL__c ;
     //String Method = apiSetting.RSA_Method__c;
     
     if(apiSetting.RSA_Method__c == 'GET' && !String.isblank(requestBody))
     {	String parameterString = ''; 
      if(!requestBody.contains('{'))
      {
          parameterString = requestBody;
      }  
      else
      {
          Map<String,String> urlParametersMap = new Map<String,String>();
          urlParametersMap = (Map<String,String>) JSON.deserialize(requestBody, Map<String,String>.class);
          for(String key: urlParametersMap.keySet())
          {	
              if(!String.isBlank(parameterString))
              {
                  parameterString += '&' ;
              }
              parameterString += key + '='+ urlParametersMap.get(key) ;
          }
      } 
      EndPointUrl = EndPointUrl.replace('parameters',parameterString);
      requestBody = null;
     }
     if(!String.isBlank(calloutWrapper.urlParameter))
     {
         EndPointUrl = EndPointUrl.replace('parameters',calloutWrapper.urlParameter);
     }
     if(headerParametersMap.containsKey('Authorization'))
     {
         headerParametersMap.put('Authorization', 'Bearer '+accessToken);
         
     }
     else
     {
         headerParametersMap.put('Authorization', 'Bearer '+accessToken);
     }
     
     formHTTPRequest(apiSetting);
     return new requestWrapper(request,authRecord,updateToken);
    }
    
    
	//This method is used to form HTTP Request

    public void formHTTPRequest(RSA_EndPoint_URL__c apiSetting) {
        
        request = new HTTPRequest();
        addHeaderParameters();
        //request.setHeader('client_id','G61LzcSEiNGmyKCHZa2fdgTbFsDIDda4');
        
        String method = apiSetting.RSA_Method__c;
        
        request.setEndpoint(EndPointUrl);
        request.setMethod(method);
        request.setTimeout(Integer.valueOf(50000));
        if(String.isNotEmpty(requestBody)) 
        {
            request.setBody(requestBody);
        }
        System.debug('request body::'+request.getBody());
        
    }
    
    public class requestWrapper{
        public HTTPrequest httpreq;
        public Rew_Authorization_Token__c authRecord ;
        public Boolean isInsertAuth ;
        requestWrapper(HTTPrequest req, Rew_Authorization_Token__c authObj,Boolean updateToken)
        {    
            httpreq = req;
            authRecord = authObj ;
            isInsertAuth = updateToken;
        }
    }

    @AuraEnabled
    public static string Xirsa_JWTencryptedbody(String jsonbody,string random){
        
            string strJWT;
            JSONGenerator header = JSON.createGenerator(false); 
            header.writeStartObject();
            header.writeStringField('alg', 'RS256');
            header.writeStringField('typ', 'JWT');
            header.writeEndObject();
            //Encode the header 
            String encodedHeader = base64URLencode(Blob.valueOf(header.getAsString()));
            //System.debug('Username::'+userName + 'UserRole::'+userRole);
            //create request body or claims body
            //ur call request json body string
            //Encode the request body string
            strJWT = encodedHeader + '.' + base64URLencode(Blob.valueOf(jsonbody));
            //To get the private key first need to generate the random numbers between 1 to 5
            string privatekey = '';
            //use this random number to get the data from custom metadata
            Rew_JWTKeys__mdt objkeysMtdt = [SELECT Rew_Public_Key__c,
                                            Rew_Private_Key__c,MasterLabel 
                                            FROM Rew_JWTKeys__mdt 
                                            WHERE MasterLabel =: random];
            System.debug('Rew_JWTKeys__mdt::'+objkeysMtdt);
            
            if(objkeysMtdt.Rew_Private_Key__c != NULL){
                privatekey = objkeysMtdt.Rew_Private_Key__c;
            }
            
            //Sign the header and body with private key by using RSA-256 algo
            Blob signature = null;
            Blob key= EncodingUtil.base64Decode(privatekey);
            signature = Crypto.sign('rsa-sha256', Blob.valueOf(strJWT ), key);
            strJWT += '.' + base64URLencode(signature); 
            system.debug('strJWT ======'+strJWT );
            JSONGenerator gen = JSON.createGenerator(true);    
            gen.writeStartObject();                    
            
            gen.writeStringField('jwt',strJWT);
            gen.writeEndObject(); 
            
            
            String encyptedjsonBody = gen.getAsString();
            return encyptedjsonBody;
            
        }
        */
    
    }
}