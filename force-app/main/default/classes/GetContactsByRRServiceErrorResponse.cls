public with sharing class GetContactsByRRServiceErrorResponse {
    
    public String result;
    public Object errorMessage;

    public GetContactsByRRServiceErrorResponse(String result, Object errorMessage) {
        this.result = result;
        this.errorMessage = errorMessage;
    }
}