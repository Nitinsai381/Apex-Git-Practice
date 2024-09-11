public class RestApiTask {
    public static HttpResponse test(){
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndPoint('https://api.restful-api.dev/objects');
        request.setMethod('GET');
       // List<Object> result=new List<Object>();
        HttpResponse response=http.send(request);
        if(response.getStatusCode()==200){
            List<Object> results=(List<Object>)JSON.deserializeUntyped(response.getBody());
            System.debug(results);
        
       List<Gadget__c> users=new List<Gadget__c>();
        for(Object user:results){
             Map<String,Object> userMap=(Map<String,Object>)user;
            Gadget__c records=new Gadget__c(
                name__c=(String) userMap.get('name'),
                id__c=(String) userMap.get('id'));
                 //data__c=(String) userMap.get('data'));
            
            users.add(records);
               }
              
              if(!users.isEmpty()){
               insert users;
              }

    }
    return response;
}
public static HttpResponse makePostCallout(){
    Http http=new Http();
    HttpRequest request=new HttpRequest();
    request.setEndPoint('https://api.restful-api.dev/objects');
    request.setMethod('POST');
    request.setHeader('Content-Type','application/json;charset=UTF-8');
    request.setBody('{"name__c":"iphone","id__c":"01"}');
   // String payload=JSON.serialize(new Map<String,Object>{'name'=>'iphone','id'=>'01'});
    Httpresponse response=Http.send(request);
    if(response.getStatusCode()!=200){
        System.debug('The status code returned was not expected');
       // request.setBody(payload);
      
    }
    else{
        System.debug(response.getBody());
    }


return response;
}
}