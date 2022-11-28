class CategoriesModel
{
  late bool status;
  late CategoriesModelData data;
  CategoriesModel.fromjson(Map <String,dynamic> json)
  {
    status = json['status'];
    data = CategoriesModelData.fromjson(json['data']);
  }
}

class CategoriesModelData
{
  List<DataModel> data = [];
  CategoriesModelData.fromjson(Map <String,dynamic> json)
  {
    json['data'].forEach((e) {
      data.add(DataModel.fromjson(e));
    } );
  }
}

class DataModel
{
  late int id;
  late String name;
  late String image;

  DataModel.fromjson(Map<String,dynamic> json)
  {
   id = json['id'];
   name = json['name'];
   image = json['image'];
  }
}