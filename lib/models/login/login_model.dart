class UserLoginModel
{
  late bool status;
  late String? message;
  late LoginUserData? data;

  UserLoginModel.fromjson(Map<String,dynamic> json)
  {
   status = json['status'];
   message = json['message'];
   data = json['data'] != null? LoginUserData.fromjson(json['data']) : null ;
  }
}

class LoginUserData
{
  late int? id;
  late String? name;
  late String? email;
  late String? phone;
  late String? image;
  late String? token;

  LoginUserData.fromjson(Map<String,dynamic> userJson)
  {
    id = userJson['id'];
    name = userJson['name'];
    email = userJson['email'];
    phone = userJson['phone'];
    image = userJson['image'];
    token = userJson['token'];
  }
}