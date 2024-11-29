
public  class JsonMethodsDemo {
    public static void serializeDemo() {
        JsonSerializeDemo p = new JsonSerializeDemo('John' , 43);
        System.debug('before serialize' +p);
        String jsonData = JSON.serialize(p);
        System.debug('after serialize' + jsonData);
    }
    public static void deserializeDemo(){
        String jsonData = '{"name" : "Ruth" , "age" : 30}';
        System.debug('before deserialize' + jsonData);
        JsonSerializeDemo deserialize = (JsonSerializeDemo) JSON.deserialize(jsonData, JsonSerializeDemo.class);
        System.debug('after deserialize' + deserialize);
    }
    public static void deserializeUntyped(){
        String jsonData = '{"name" : "prathibha" , "age" : 30 , "isActive" : "true"}';
        System.debug('before deserializeUntyped' +jsonData);
        Map<String , Object>  deserializeUntyped = (Map<String , Object>) JSON.deserializeUntyped(jsonData);
        System.debug('after deserializeUntyped' +deserializeUntyped);
    }
    public static void deserializeStrict(){
        String jsonData = '{"name" : "prathibha" , "age" : 30 , "isActive" : "true"}';
        System.debug('before deserializeStrict' +jsonData);
        try{
            JsonSerializeDemo deserializeStrict =(JsonSerializeDemo) JSON.deserializeStrict(jsonData, JsonSerializeDemo.class);
            System.debug('after deserializeStrict' +deserializeStrict);
        }
        catch(Exception e){
            System.debug('error message' +e.getMessage());
        }
    }
    public static void generateJson() {
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('name', 'Prathibha');
        gen.writeNumberField('age', 23);
        gen.writeFieldName('address');
        gen.writeStartObject();
        gen.writeStringField('House no :', '3-10');
        gen.writeStringField('village', 'Sirpur');
        gen.writeStringField('dist', 'Nizamabad');
        gen.writeEndObject(); 
        gen.writeEndObject();
        String jsonString = gen.getAsString();
        System.debug('Before Deserialize: ' + jsonString);
        Map<String , Object> mapFields = (Map<String , Object>) JSON.deserializeUntyped(jsonString);
        System.debug('after Deserialize' +mapFields);
    }
    
}