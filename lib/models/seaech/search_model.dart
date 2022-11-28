List<Data> searchData = [];

class SearchModel {
  late bool status;
  SearchModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    searchData = [];
    json["data"]["data"].forEach((element) {
      searchData.add(Data.fromjson(element));
    });
  }
}

class Data {
  late String name;
  late dynamic price;
  late String image;
  late int id;

  Data.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    price = json["price"];
    image = json["image"];
    id = json["id"];
  }
}
