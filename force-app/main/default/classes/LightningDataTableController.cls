/*
    Generic Lightning Data Table Controller class
*/
public with sharing class LightningDataTableController {

    public static DataTableResponse getRecords(String strObjectName, String strFieldSetName){                
       	
        //Get the fields from FieldSet
        Schema.SObjectType sObjectTypeObj = Schema.getGlobalDescribe().get(strObjectName);
        Schema.DescribeSObjectResult describeSObjectResultObj = SObjectTypeObj.getDescribe();            
        Schema.FieldSet fieldSetObj = describeSObjectResultObj.FieldSets.getMap().get(strFieldSetName);
        
        //To hold the table hearders 
        List<DataTableColumns> lstDataColumns = new List<DataTableColumns>();
        
        //Field to be queried - fetched from fieldset
        List<String> lstFieldsToQuery = new List<String>();
        
        //The final wrapper response to return to component
        DataTableResponse response = new DataTableResponse();
        
        for( Schema.FieldSetMember theFieldSetMember : fieldSetObj.getFields() ){
            String dataType = String.valueOf(theFieldSetMember.getType()).toLowerCase();
            //This way we can set the type of a column
            //We do not get the exact type from schema object which matches to lightning:datatable component structure
            if(dataType == 'datetime'){
                dataType = 'date';
            }
            //Create a wrapper instance and store label, fieldname and type.
            DataTableColumns datacolumns = new DataTableColumns( String.valueOf(theFieldSetMember.getLabel()) , 
                                                                 String.valueOf(theFieldSetMember.getFieldPath()), 
                                                                 String.valueOf(theFieldSetMember.getType()).toLowerCase() );
			lstDataColumns.add(datacolumns);
            lstFieldsToQuery.add(String.valueOf(theFieldSetMember.getFieldPath()));
        }
        
        //Form an SOQL to fetch the data - Set the wrapper instance and return as response
        if(! lstDataColumns.isEmpty()) {      
         //   System.debug('====recIds====' + recIds);
            response.lstDataTableColumns = lstDataColumns;
            String query = 'SELECT ' + String.join(lstFieldsToQuery, ',') + ' FROM ' + strObjectName + '';
          //  if(null != recIds) {
         //       query += ' WHERE Id IN : recIds '; 
         //   }
            System.debug('====query====' + query);
            System.debug('====Database.query(query)====' + Database.query(query));
            response.lstDataTableData = Database.query(query);
        }
        return response;
    }

    //Wrapper class to hold Columns with headers
    public class DataTableColumns {
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled       
        public String fieldName {get;set;}
        @AuraEnabled
        public String type {get;set;}
        
        //Create and set three variables label, fieldname and type as required by the lightning:datatable
        public DataTableColumns(String label, String fieldName, String type){
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;            
        }
    }
    
    //Wrapper calss to hold response - This response is used in the lightning:datatable component
    public class DataTableResponse {
        @AuraEnabled
        public List<DataTableColumns> lstDataTableColumns {get;set;}
        @AuraEnabled
        public List<sObject> lstDataTableData {get;set;}                
        
        public DataTableResponse(){
            lstDataTableColumns = new List<DataTableColumns>();
            lstDataTableData = new List<sObject>();
        }
    }
}