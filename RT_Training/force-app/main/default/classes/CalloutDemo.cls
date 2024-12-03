public class CalloutDemo {
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
}

