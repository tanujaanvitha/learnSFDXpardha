global class APIResponse{
  
  public boolean success {get; private set;}
  public List<APIResponseItem> results {get; private set;}
  
  private APIResponse(list<APIResponseItem> results){
    this.success = true;
    this.results = results;
    for(APIResponseItem item : this.results)
      this.success &= item.success;
  }

    
    /** Save Result instatiation **/
    public static APIResponse getResponse(sObject source, Database.SaveResult result){
        return getResponse(new List<sObject>{source}, new List<Database.SaveResult>{ result });
    }
    public static APIResponse getResponse(list<sObject> source, List<Database.SaveResult> resultlist){
        list<APIResponseItem> results = new list<APIResponseItem>();  
        for( integer i=0; i < resultlist.size(); i++)     
            results.add(new APIResponseItem(source[i],resultlist[i]));
        return new APIResponse(results);
    }
        
    /** Upsert Result instatiation **/
    public static APIResponse getResponse(sObject source, Database.UpsertResult result){
            return getResponse(new List<sObject>{ source}, new List<Database.UpsertResult>{ result });
    } 
    public static APIResponse getResponse(list<sObject> source, List<Database.UpsertResult> resultlist){ 
        list<APIResponseItem> results = new list<APIResponseItem>();        
        for( integer i=0; i < resultlist.size(); i++)     
            results.add(new APIResponseItem(source[i],resultlist[i]));
        return new APIResponse(results);
    }
    
    /** Delete Result instatiation **/
    public static APIResponse getResponse(sObject source, Database.DeleteResult result){
            return getResponse(new List<sObject>{ source}, new List<Database.DeleteResult>{ result });
    } 
    public static APIResponse getResponse(list<sObject> source, List<Database.DeleteResult> resultlist){ 
        list<APIResponseItem> results = new list<APIResponseItem>();        
        for( integer i=0; i < resultlist.size(); i++)     
            results.add(new APIResponseItem(source[i],resultlist[i]));
        return new APIResponse(results);
    }

    /** Undelete Result instatiation **/
    public static APIResponse getResponse(sObject source, Database.UndeleteResult result){
            return getResponse(new List<sObject>{ source}, new List<Database.UndeleteResult>{ result });
    } 
    public static APIResponse getResponse(List<sObject> source, List<Database.UndeleteResult> resultlist){ 
        list<APIResponseItem> results = new list<APIResponseItem>();        
        for( integer i=0; i < resultlist.size(); i++)     
            results.add(new APIResponseItem(source[i],resultlist[i]));
        return new APIResponse(results);
    }
        
  public class APIResponseItem{
      public boolean success { get; private set; }
      public list<Database.Error> errors { get; private set; }
      public sObject target { get; private set; }
      public Id salesForceId {get; private set; }
    
      private APIResponseItem(){
          success = false;
          errors = new list<Database.Error>();
          salesForceId = null;
          target = null;
      }      
      /** Save Result instatiation **/
      private APIResponseItem(sObject source, Database.SaveResult result){
          this();
          this.success = result.isSuccess();
          this.salesForceId = result.getId();
          this.target = source;
          errors.addAll(result.getErrors());
      }
      /** Upsert Result instatiation **/
      private APIResponseItem(sObject source, Database.UpsertResult result){
          this();
          this.success = result.isSuccess();
          this.salesForceId = result.getId();
          this.target = source;
          errors.addAll(result.getErrors());
      }   
      /** Delete Result instatiation **/
      private APIResponseItem(sObject source, Database.DeleteResult result){
          this();
          this.success = result.isSuccess();
          this.salesForceId = result.getId();
          this.target = source;
          errors.addAll(result.getErrors());
      }   
      /** Undelete Result instatiation **/
      private APIResponseItem(sObject source, Database.UndeleteResult result){
          this();
          this.success = result.isSuccess();
          this.salesForceId = result.getId();
          this.target = source;
          errors.addAll(result.getErrors());
      }
  }   
}