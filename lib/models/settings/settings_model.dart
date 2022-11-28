class Profile
{
  late String? message;
  late UserData data;
  Profile.fromjson(Map<String, dynamic> json)
  {
    message = json['message'];
    data = UserData.fromjson(json['data']);
  }
}

class UserData
{
  late String name;
  late String email;
  late String phone;
  UserData.fromjson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
}