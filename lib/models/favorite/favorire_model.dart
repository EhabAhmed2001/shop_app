class GetFavoriteData {
  late bool status;
  late GetData data;

  GetFavoriteData.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = GetData.fromjson(json['data']);
  }
}

late List<GetProductFavoriteData> favoriteScreenData=[];

class GetData {
  GetData.fromjson(Map<String, dynamic> json) {
    favoriteScreenData =[];
    json['data'].forEach((element) {
      favoriteScreenData.add(GetProductFavoriteData.fromjson(element));
    });
  }
}

class GetProductFavoriteData {
late int favoriteId;
  late ProductInfo products;

  GetProductFavoriteData.fromjson(Map<String, dynamic> json) {
    favoriteId = json['id'];
    products = ProductInfo.fromjson(json['product']);
  }
}

class ProductInfo {
  late int productId;
  late dynamic productPrice;
  late dynamic productOldPrice;
  late int productDiscount;
  late String productImage;
  late String productName;
  ProductInfo.fromjson(Map<String, dynamic> json) {
    productId = json['id'];
    productPrice = json['price'];
    productOldPrice = json['old_price'];
    productDiscount = json['discount'];
    productImage = json['image'];
    productName = json['name'];

  }
}

//==========================

class FavoriteModelChange
{
  late bool status;
  late String message;
  FavoriteModelChange.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'].toString();
  }
}