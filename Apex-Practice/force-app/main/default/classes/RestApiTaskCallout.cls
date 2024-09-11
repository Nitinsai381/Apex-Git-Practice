@isTest
private class RestApiTaskCallout {
    // @isTest
    // static void postTest() {
    //     Test.setMock(HttpCalloutMock.class,new RestApiTaskMockCallout());
    //     HttpResponse response=RestApiTask.makePostCallout();
    //     String contentType = response.getHeader('Content-Type');
    //     System.Assert.isTrue(contentType == 'application/json');
    //     String  actualValue = response.getBody();
    //     System.debug(response.getBody());
    //     String expectedValue='[{"id":"oo1","name":"iphone1pro"}]';
    //     Assert.areEqual(expectedValue, actualValue);
    // Assert.areEqual(200, response.getStatusCode());
    // }
    @isTest
    static void getTest() {
        Test.setMock(HttpCalloutMock.class,new RestApiTaskMockCallout());
        HttpResponse response=RestApiTask.test();
        String actualValue = response.getBody();
        String expectedValue='[{"name":"iphone1pro","id":"001"}]';
        Assert.areEqual(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());

    }
}