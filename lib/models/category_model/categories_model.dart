class CategoryModel{
  late bool status;
  late CategoryModelData data;
  CategoryModel.fromJson(Map<String ,dynamic>json)
  {
    status = json['status'];
    data = CategoryModelData.fromJson(json['data']);
  }
}

class CategoryModelData{
  late int currentPage;
  List<ModelData> data = <ModelData> [];
  CategoryModelData.fromJson(Map<String ,dynamic>json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element) => data.add(ModelData.fromJson(element)));
  }
}

class ModelData {
  late int id;
  late String name;
  late String image;
  ModelData.fromJson(Map<String ,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
