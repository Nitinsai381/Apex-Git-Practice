@isTest
global class MockHttpResponseRestApiCustomObject implements HttpCalloutMock {
    
    global HttpResponse respond(HttpRequest req) {
        
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200); 
        
        
        String mockResponseBody = '[{"name":"John smith","email":"john.smith@example.com","phone":"1234567890","status":"active"},'
                                + '{"name":"Jane Smith","email":"jane.smith@example.com","phone":"0987654321","status":"inactive"}]';
        
        res.setBody(mockResponseBody);
        return res;
    }
}