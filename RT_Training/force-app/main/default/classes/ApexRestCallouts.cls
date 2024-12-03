public with sharing class ApexRestCallouts {
    public static void  getUsersData() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://reqres.in/api/users?page=2');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            Map<String , Object> result = (Map<String , Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> res = (List<Object>) result.get('data');
            for(Object r : res){
                System.debug('data' +r);
            }
        }

    }
    public static void postExample(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://reqres.in/api/users');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{ "name": "morpheus", "job": "leader"}');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }

    }

    public static void putExample(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://reqres.in/api/users/2');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{ "name": "morpheus", "job": "zion resident"}');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }

    }

    public static void patchExample(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://reqres.in/api/users/2');
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name": "morpheus","job": "zion resident"}');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }

    }

    public static void deleteExample(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://reqres.in/api/users/2');
        request.setMethod('DELETE');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 204){
            System.debug('status '+ response.getStatusCode());
        }

    }
}