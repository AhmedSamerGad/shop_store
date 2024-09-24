class FavoriteModel {
  late bool status;
  String? message;
  FavoriteModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
