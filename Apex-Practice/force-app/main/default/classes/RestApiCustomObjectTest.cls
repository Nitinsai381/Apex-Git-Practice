@isTest
public class RestApiCustomObjectTest {

    @isTest
    static void testGetDataFromApi() {

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseRestApiCustomObject());
        HttpResponse response =  RestApiCustomObject.getdatafromapi();
        String contentType = response.getHeader('Content-Type');
        System.Assert.isTrue(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '[{"name":"John smith","email":"john.smith@example.com","phone":"1234567890","status":"active"},'
                                + '{"name":"Jane Smith","email":"jane.smith@example.com","phone":"0987654321","status":"inactive"}]';
        
        System.Assert.areEqual(expectedValue, actualValue);
        System.Assert.areEqual(200, response.getStatusCode());


        
    }
}