public abstract class ReparentingLookupRecords {
    public abstract void doReparenting(Id parentId , List<Id> childIds);
}






































    //  protected Map<String, Schema.SObjectField> getFieldsByObjectType(String parentType,Schema.SObjectType SobjType ){
    //     Map<String, Schema.SObjectField> fieldsMap = new Map<String, Schema.SObjectField>();
    //     Map<String ,SObjectField>  fields = SobjType.getDescribe().fields.getMap();
    //     if(fields.containsKey(parentType))
    // }

 

    // protected Map<Schema.SObjectType, Schema.SObjectField> getFieldsByObjectType(String parentType, Schema.SObjectType SobjType) {
    //     Map<Schema.SObjectType, Schema.SObjectField> fieldsMap = new Map<Schema.SObjectType, Schema.SObjectField>();
    //     Schema.SObjectType parentSObjectType = Schema.getGlobalDescribe().get(parentType);
    
    //     for (Schema.SObjectField field : SobjType.getDescribe().fields.getMap().values()) {
    //         if (field.getDescribe().isReference() && field.getDescribe().getReferenceTo().contains(parentSObjectType)) {
    //             fieldsMap.put(SobjType, field);
    //         }
    //     }
    //     return fieldsMap;
    // }



// protected Map<String, Schema.SObjectField> getFieldsByObjectType(String parentType, Schema.SObjectType SobjType) {
//     Map<String, Schema.SObjectField> fieldsMap = new Map<String, Schema.SObjectField>();
//     fieldsMap.put('Case', Schema.Case.ContactId);
//     fieldsMap.put('PlatformDemo__c', Schema.PlatformDemo__c.Contact__c);
    
//     // Check if the specified parent type is in the map
//     if (fieldsMap.containsKey(parentType)) {
//         // Verify if the SObjectType matches the provided parentType
//         if (SobjType.getDescribe().getName() == parentType) {
//             return new Map<String, Schema.SObjectField> { parentType => fieldsMap.get(parentType) };
//         }
//     }
    
//     // Return an empty map if conditions are not met
//     return new Map<String, Schema.SObjectField>();
// }


    // protected Map<String, Schema.SObjectField> getObjectRelationships(Schema.SObjectType childSObject, String parentType) {
    //     Map<String, Schema.SObjectField> childFields = childSObject.getDescribe().fields.getMap();
    //     Map<String, Schema.SObjectField> relationshipFields = new Map<String, Schema.SObjectField>();
    //     for (String fieldName : childFields.keySet()) {
    //         Schema.SObjectField field = childFields.get(fieldName);
    //         if (field.getDescribe().getType() == Schema.DisplayType.REFERENCE) {
    //             List<Schema.SObjectType> referenceTo = field.getDescribe().getReferenceTo();
    //             if (referenceTo.contains(Schema.getGlobalDescribe().get(parentType))) {
    //                 relationshipFields.put(fieldName, field);
    //             }
    //         }
    //     }

    //     return relationshipFields;
    // }

    
//}