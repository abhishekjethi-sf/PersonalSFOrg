public class StringArrayTest {
    public static list<String> generateStringArray(Integer count){
    	list<String> returnedResults = new list<String>();
    	// Process the data
    	for(Integer i=0;i<count;i++){
    		returnedResults.add('Test '+i);
    	}	
    	system.debug('######returnedResults##'+returnedResults);
    	return returnedResults;
    }
}