public  class DynamicTableWrapper {
    @AuraEnabled
    public List<ObjectFieldConfig__mdt> labels;
    @AuraEnabled
    public List<SObject> objectData;
    public DynamicTableWrapper( List<ObjectFieldConfig__mdt> labels) {
        this.labels = labels;
    }
    public DynamicTableWrapper(List<SObject> objectData){
        this.objectData = objectData;
    }
}