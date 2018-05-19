global abstract class APIBase {
    protected APIBase(){
    }
    global abstract sObject AsObject(); 
    
    /** Helper function to return list from the untyped Request object **/
    public static list<string> ListOfString(blob content){
        list<string> results = new list<string>();
          for(object objInstance : ((Map<string,object>)JSON.deserializeUntyped(content.toString())).values())
              results.add(string.valueOf(objInstance));
    return results;
    }
    /** Returns recordId that is contained in the path-element **/
    public static String pathElement(RestRequest request) {
        return request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
    }
    
    /** common exception **/
    public class APIException extends Exception{}    
    
    /** exception reformatting for JSON **/
    public static string formatException(exception ex){
        string result = '"exception" : {';  
    result += ' "cause" : {' + ((ex.getCause() != null) ? formatException(ex.getCause()) : '') + '},';  
    result += ' "lineNumber" : ' + ex.getLineNumber() + ',';   
    result += ' "message" : ' + ex.getMessage() + ',';
    result += ' "typeName" : ' + ex.getTypeName() + ',';
    result += ' "stackTrace" : ' + ex.getStackTraceString() + '}';
    return result;
    }
}