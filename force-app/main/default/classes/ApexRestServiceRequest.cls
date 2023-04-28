public class ApexRestServiceRequest {
	
	public list<ContactData> Data;
	
	public class ContactData{
		public String email;
	}
}
/*
JSON String
{  
   "Data":[  
      {  
         "email":"abhishekjethi@gmail.com"
      },
      {  
         "email":"abhishekjethi11@gmail.com"
      },
      {  
         "email":"abhishekjethi87@gmail.com"
      }
   ]
}
*/