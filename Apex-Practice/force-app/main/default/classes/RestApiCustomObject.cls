public with sharing class RestApiCustomObject {
    public static HttpResponse getdatafromapi(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://gorest.co.in/public/v2/users'); 
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            List<Object> users = (List<Object>) JSON.deserializeUntyped(response.getBody());
            
          
            List<External_Data__c> recordsToInsert = new List<External_Data__c>();
               
            for (Object user : users) {
                Map<String, Object> userData = (Map<String, Object>) user;
                External_Data__c record = new External_Data__c(
                    Name = (String) userData.get('name'),
                    Email__c = (String) userData.get('email'),
                    Phone__c = (String) userData.get('phone'), 
                    Status__c = (String) userData.get('status')
                );
                recordsToInsert.add(record);
            }

            if(!recordsToInsert.isEmpty()) {
                insert recordsToInsert;
            }
        }
        return response;



    }
    public static void createdatainapi(){
        List<External_Data__c> records = [SELECT Id, Name, Email__c, Phone__c, Status__c FROM External_Data__c LIMIT 1];
         
        if (records.size() > 0) {
            External_Data__c record = records[0]; 
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://gorest.co.in/public/v2/users');
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer ACCESS_TOKEN');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            
            String jsonBody=JSON.serialize(      '{"id": 73950211,"name": "Anil Ethiri", "email": "ani_embranthiri@sipes.example","gender": "ale","status": "acive"}');
            
            request.setBody(jsonBody);
            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 201) {
                System.debug('Record created successfully in external system: ' + response.getBody());
            } else {
                System.debug('Failed to create record: ' + response.getStatus());
            }


        
        }


    }
    /*
    public static void updatedatainapi(){
        List<External_Data__c> records = [SELECT Id, Name, Email__c, Phone__c, Status__c FROM External_Data__c LIMIT 1];
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://gorest.co.in/public/v2/users/123'); 
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        String jsonBody = JSON.serialize(new Map<String, Object>{'name' => record.Name,'email' => record.Email__c,'phone' => record.Phone__c,'status' => record.Status__c});
        request.setBody(jsonBody);

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            System.debug('Record updated successfully in external system: ' + response.getBody());
        } else {
            System.debug('Failed to update record: ' + response.getStatus());
        }


    }
        */
}