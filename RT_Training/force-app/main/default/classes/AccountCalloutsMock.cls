@isTest
global class AccountCalloutsMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('  { "id": "1", "name": "Google Pixel 6 Pro", "data": {   "color": "Cloudy White", "capacity": "128 GB"  } }');
        response.setStatusCode(200);
        return response;

    }
}