@isTest
private class AccountCalloutsTest{
    @isTest
    static void testGetCallout(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('AccountResources');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = AccountCallouts.fetchAndCreateAccounts();
        Assert.areNotEqual(200, result.getStatusCode(),'this status code is not 200');
        Assert.areEqual('application/json;charset=UTF-8', result.getHeader('Content-Type'),'this content type is not expected');

    }
    @isTest
static void testPostCallout() {
    Test.setMock(HttpCalloutMock.class, new AccountCalloutsMock());
    HttpResponse response = AccountCallouts.createRecordsInExternal();
    // Verify that the response received contains fake values
    String contentType = response.getHeader('Content-Type');
    Assert.isTrue(contentType == 'application/json');
    String actualValue = response.getBody();
    System.debug(response.getBody());
    String expectedValue = '  { "id": "1", "name": "Google Pixel 6 Pro", "data": {   "color": "Cloudy White", "capacity": "128 GB"  } }';
    Assert.areEqual(expectedValue, actualValue);
    Assert.areEqual(200, response.getStatusCode());
}
}