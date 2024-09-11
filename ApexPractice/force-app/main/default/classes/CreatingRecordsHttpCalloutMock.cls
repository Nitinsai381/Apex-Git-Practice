@isTest
global class CreatingRecordsHttpCalloutMock implements HttpCalloutMock {
  global HttpResponse respond(HttpRequest request) {
    HttpResponse response = new HttpResponse();
    response.setHeader('Content-Type', 'application/json;charset=UTF-8');
    if (request.getMethod() == 'POST') {
      response.setBody('[{"name":"Google Pixel 8888"}]');
    } else if (request.getMethod() == 'GET') {
      response.setBody('[{"name":"Google Pixel 6 pro"}]');
    }
    response.setStatusCode(200);
    return response;
  }
}