public with sharing class GetContactsByRRServiceSuccessResponse {
	
	public String DataSetName;
	public list < CustomerData > Data;

    // INNER CLASS for Customer data
    public class CustomerData {
        public String CustomerNumber;
        public list<ContactData> Contacts;
    }

    // INNER CLASS for Contacts data
    public class ContactData {
    	public String ContactId;
        public String FirstName;
        public String LastName;
        public String Email;
        public Datetime CreatedDate;
        public Datetime LastModifiedDate;
    }    
}

/*

JSON output
{  
   "DataSetName":"GetRRContacts",
   "Data":[  
      {  
         "CustomerNumber":"6666",
         "Contacts":[  
         ]
      },
      {  
         "CustomerNumber":"234324",
         "Contacts":[  
            {  
               "ContactId":"0037F00001G2bg8QAB",
               "LastName":"AJ User # 1",
               "Email":"test@test.com",
               "CreatedDate":"2019-02-05T05:51:07.000Z",
               "LastModifiedDate":"2019-02-05T05:51:07.000Z"
            },
            {  
               "ContactId":"0037F00001G2bgrQAB",
               "LastName":"AJ User # 2",
               "Email":"test@test.com",
               "CreatedDate":"2019-02-05T05:51:47.000Z",
               "LastModifiedDate":"2019-02-05T05:51:47.000Z"
            }
         ]
      },
      {  
         "CustomerNumber":"7777",
         "Contacts":[  
            {  
               "ContactId":"0037F00001G2bhLQAR",
               "LastName":"AJ User # 3",
               "Email":null,
               "CreatedDate":"2019-02-05T05:52:33.000Z",
               "LastModifiedDate":"2019-02-13T06:14:43.000Z"
            },
            {  
               "ContactId":"0037F00001G2bhfQAB",
               "LastName":"AJ User # 4",
               "Email":"test2@test.com",
               "CreatedDate":"2019-02-05T05:52:50.000Z",
               "LastModifiedDate":"2019-02-05T05:52:50.000Z"
            }
         ]
      }
   ]
}


*/