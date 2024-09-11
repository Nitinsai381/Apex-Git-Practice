public class AccountCallouts {

    public static HttpResponse fetchAndCreateAccounts() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.restful-api.dev/objects');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<AccountData> accountDataList = (List<AccountData>) JSON.deserialize(response.getBody(), List<AccountData>.class);
            System.debug('data' +accountDataList );
            List<Account> accountsToCreate = new List<Account>();
            for (AccountData data : accountDataList) {
                Account acc = new Account();
                acc.Name = data.name; 
                accountsToCreate.add(acc);
            }
            if (accountsToCreate.size() > 0) {
                    insert accountsToCreate;
                    System.debug('accounts' +accountsToCreate);
                    System.debug('Accounts created successfully');
        } 
    }
    return response;
}

    // Class to map the JSON response to Apex objects
    public class AccountData {
        public Integer id;
        public String name;
    }

// POST METHOD
//--------------

public static HttpResponse createRecordsInExternal(){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.restful-api.dev/objects');
    request.setMethod('POST');
    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
    request.setBody('{ "id": "12", "name": "Google Pixel 20", "data": { "color": "purple", "capacity": "32 GB" } }');
      HttpResponse response = http.send(request);
      System.debug('body'+response.getBody());
      if(response.getStatusCode() != 201) {
        System.debug('The status code returned was not expected: ' +
            response.getStatusCode() + ' ' + response.getStatus());
    } else {
        System.debug(response.getBody());
    }
    return response;
}
public static HttpResponse updateTheRecords(){
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://api.restful-api.dev/objects');
    request.setMethod('PUT');
    request.setHeader('Content-Type', 'application/json;charset=UTF-8');
    request.setBody( ' { "id": "2","name": "Apple iPhone 12 Mini pro, 256GB, Blue",  "data": null  }');
    HttpResponse response = http.send(request);
    System.debug('body'+response.getBody());
    if(response.getStatusCode() != 201) {
      System.debug('The status code returned was not expected: ' +
          response.getStatusCode() + ' ' + response.getStatus());
  } else {
      System.debug(response.getBody());
  }
  return response;
}
}