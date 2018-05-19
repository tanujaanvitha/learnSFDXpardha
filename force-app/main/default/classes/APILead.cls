@RestResource(urlMapping = '/SalesTools/api/lead/*')
global class APILead extends APIBase{
  /** REST Methods **/
  @HttpPatch
  global static void do_Patch(){
    do_Save();
  }
  @HttpPost
  global static void do_Post(){
    do_Save();
  }  
  
  @HttpGet
  global static void do_Get(){
        try{
          list<APILead> results = new list<APILead>();
          Restrequest request=Restcontext.request; 
          for(Lead sobjInstance : [select  Id, Name,FirstName, LastName,
                          Phone,
                          PostalCode,
                          State,
                          Country,
                          Email,
                          Description,
                          LeadSource
                          from Lead])
                      //    from Lead where externalid__c =:request.requestURI.substring(request.requestURI.lastIndexOf('/')+1)])
              results.add(new APILead(sobjInstance));
          RESTContext.response.responseBody = BLOB.valueOf(JSON.SerializePretty(results));  
          RESTContext.response.statusCode = results.isEmpty() ? 415 : 200;
        }     
      catch(Exception ex){
          RESTContext.response.responseBody = Blob.valueOf(APIBase.formatException(ex));
         RESTContext.response.statusCode = 415;
      }
  }
       
    private static void do_Save(){
        try{
          List<Lead> saveList = new list<Lead>();
          for( APILead saveObj : (list<APILead>)JSON.deserialize(RESTContext.request.requestBody.toString(), list<APILead>.class))
            saveList.add((Lead)saveObj.AsObject());
       //   RESTContext.response.responseBody = blob.valueOf(JSON.serializePretty(APIResponse.getResponse(saveList, Database.Upsert( saveList, Lead.externalid__c))));
        }     
      catch(Exception ex){
          RESTContext.response.responseBody = Blob.valueOf(APIBase.formatException(ex));
         RESTContext.response.statusCode = 415;
      }
    }
   
    /** Object Definition **/    
    /** Field Definition **/
    @TestVisible public string id { get; private set; }
    @TestVisible public string firstName { get; private set; }
    @TestVisible public string lastName { get; private set; }
    @TestVisible public string phone { get; private set; }
    @TestVisible public string postcode { get; private set; }
    @TestVisible public string state { get; private set; }
    @TestVisible public string country { get; private set; }
    @TestVisible public string email { get; private set; }
    @TestVisible public string description { get; private set; }
    
    @TestVisible public string leadSource { get; private set; }
   
    @TestVisible public list<leadField> customFields {get; private set;}
    
    public APILead(Map<string,object> dataMap){
        customFields = new list<leadField>();
        /** Populate fields that are defined in this object from the dataMap **/
        if (dataMap.containsKey('id')) Id = string.valueOf(dataMap.get('id'));
        if (dataMap.containsKey('firstName')) FirstName = string.valueOf(dataMap.get('firstName'));
        if (dataMap.containsKey('lastName')) LastName = string.valueOf(dataMap.get('lastName'));
        if (dataMap.containsKey('phone')) Phone = string.valueOf(dataMap.get('phone'));
        if (dataMap.containsKey('postcode')) Postcode = string.valueOf(dataMap.get('postcode'));
        if (dataMap.containsKey('state')) State = string.valueOf(dataMap.get('state'));
        if (dataMap.containsKey('country')) Country = string.valueOf(dataMap.get('country'));
        if (dataMap.containsKey('email')) Email = string.valueOf(dataMap.get('email'));
        if (dataMap.containsKey('description')) Description = string.valueOf(dataMap.get('description'));
        
    }
    
    @TestVisible private APILead(Lead sobjInstance){
        /** Populate fields that are defined in this object from the Lead record **/
    //    this.Id = sobjInstance.externalid__c;
        this.FirstName = sobjInstance.FirstName;
        this.LastName = sobjInstance.LastName;
        this.Phone = sobjInstance.Phone;
        this.Postcode = sobjInstance.PostalCode;
        this.State = sobjInstance.State ;
        this.Country = sobjInstance.Country;
        this.Email = sobjInstance.Email;
        this.Description = sobjInstance.Description;
        this.LeadSource = sobjInstance.LeadSource;
        
    }
  
    global override sObject AsObject(){
    Lead sobjInstance = new Lead();
  //      sobjInstance.externalid__c = this.Id;
        sobjInstance.FirstName = this.FirstName;
        sobjInstance.LastName = this.LastName;
        sobjInstance.Phone = this.Phone;
        sobjInstance.PostalCode = this.Postcode;
        sobjInstance.State = this.State;
        sobjInstance.Country = this.Country;
        sobjInstance.Email = this.Email;
        sobjInstance.Description = this.Description;
        sobjInstance.LeadSource = this.LeadSource;
        sobjInstance.Status = 'Open';    
        return sobjInstance;
    }
    public class leadField{
        public leadField(string name, string value){
          this.name = name;
          this.value = value;  
        }
        public string name{ get; private set;}
        public string value{get; private set;}
    }
}