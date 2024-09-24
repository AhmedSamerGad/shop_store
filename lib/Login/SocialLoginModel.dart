class login_model {
  bool? status;
  String? message;
  UserData? data;
  login_model.fromjason(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromjason(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? credit;
  UserData.fromjason(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
    credit = json['credit'];
  }
}
