@isTest
public class CreatingRecordsTest {
  @isTest
  static void getCreateResponseTest() {
    Test.setMock(HttpCalloutMock.class, new CreatingRecordsHttpCalloutMock());
    HttpResponse response = new CreatingRecords().getCreateResponse();
    String contentType = response.getHeader('Content-Type');
    Assert.isTrue(contentType == 'application/json;charset=UTF-8');
    String actualValue = response.getBody();
    System.debug(response.getBody());
    String expectedValue = '[{"name":"Google Pixel 6 pro"}]';
    Assert.areEqual(expectedValue, actualValue);
    Assert.areEqual(200, response.getStatusCode());
  }
  @isTest
  static void postCreateRecordTest() {
    Test.setMock(HttpCalloutMock.class, new CreatingRecordsHttpCalloutMock());
    HttpResponse response = new CreatingRecords().postCreateRecord();
    String contentType = response.getHeader('Content-Type');
    Assert.isTrue(contentType == 'application/json;charset=UTF-8');
    String actualValue = response.getBody();
    System.debug(response.getBody());
    String expectedValue = '[{"name":"Google Pixel 8888"}]';
    Assert.areEqual(expectedValue, actualValue);
    Assert.areEqual(200, response.getStatusCode());
  }
}