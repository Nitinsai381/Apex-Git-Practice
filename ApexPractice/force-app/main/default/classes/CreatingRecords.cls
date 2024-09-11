public class CreatingRecords {
  public HttpResponse getCreateResponse() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.restful-api.dev/objects');
    request.setMethod('GET');
    HttpResponse response = http.send(request);
    List<External_User__c> extList = new List<External_User__c>();
    if (response.getStatusCode() == 200) {
      List<Object> results = (List<Object>) JSON.deserializeUntyped(
        response.getBody()
      );

      for (Object records : results) {
        System.debug(records);
        Map<String, Object> recordMap = (Map<String, Object>) records;

        External_User__c obj = new External_User__c();

        obj.Name = (String) recordMap.get('name');
        obj.id__c = (String) recordMap.get('id');

        Object dataObject = recordMap.get('data');
        Map<String, Object> mapData = (Map<String, Object>) dataObject;
        //obj.Data__c = (String) records.get('data');
        obj.Data__c = JSON.serialize(dataObject);
        extList.add(obj);
      }
      insert extList;
    }
    return response;
  }
  public HttpResponse postCreateRecord() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.restful-api.dev/objects');
    request.setMethod('POST');
    request.setHeader('content-Type', 'application/json;charset=UTF-8');
    request.setBody('{"name":"Google Pixel 8888"}');
    String payload = JSON.serialize(
      new Map<String, Object>{ 'name' => 'Google Pixel 8888' }
    );
    HttpResponse response = http.send(request);
    if (response.getStatusCode() == 201) {
      System.debug(
        'The status code returned was not expected:' +
          response.getStatusCode() +
          '' +
          response.getStatus()
      );
      request.setBody(payload);
    } else {
      System.debug(
        'The status code returned was successfull' +
          ' ' +
          response.getStatusCode()
      );
    }
    return response;
  }
  public HttpResponse putCreateRecord() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.restful-api.dev/objects/7');
    request.setMethod('PUT');
    request.setHeader('content-Type', 'application/json;charset=UTF-8');
    request.setBody('{"name":"Apple macbook 18 pro"}');
    String payload = JSON.serialize(
      new Map<String, Object>{ 'name' => 'Apple macbook 18 pro' }
    );
    HttpResponse response = http.send(request);
    if (response.getStatusCode() != 200) {
      System.debug(
        'The status code returned was not expected:' +
          response.getStatusCode() +
          '' +
          response.getStatus()
      );
      request.setBody(payload);
    } else {
      System.debug(
        'The status code returned was successfull' +
          ' ' +
          response.getStatusCode()
      );
    }
    return response;
  }
}