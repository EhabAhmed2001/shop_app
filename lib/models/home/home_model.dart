class HomeModel
{
  late bool status;
  late HomeDataModel data;

  HomeModel.fromjson(Map <String,dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromjson(json['data']);
  }
}

class HomeDataModel
{
  List<Banner> banner = [];
  List<Products> products = [];
  HomeDataModel.fromjson(Map<String ,dynamic> json)
  {
    json['banners'].forEach((e){
      banner.add(Banner.fromjson(e));
    });

    json['products'].forEach((e){
      products.add(Products.fromjson(e));
    });
  }
}

class Banner
{
  String? image;
  Banner.fromjson(Map<String ,dynamic> json)
  {
    image = json['image'];
  }
}

class Products
{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late int discount;
  late String image;
  late List<dynamic> images;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  Products.fromjson(Map<String ,dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    images = json['images'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}