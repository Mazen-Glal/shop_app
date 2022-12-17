class LoginModel{
  late bool status ;
  late String message;
  late UserData data;

  LoginModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'].toString();
    data = (json['data'] != null ?  UserData.fromJson(json['data']) : null)!;
  }
}


class UserData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // named constructor
  UserData.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}