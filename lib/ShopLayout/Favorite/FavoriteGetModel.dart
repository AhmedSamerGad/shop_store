class FavoriteGetModel {
  bool? status;
  late u_Data data;

  FavoriteGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? u_Data.fromJson(json['data']) : null)!;
  }
}

class u_Data {
  List<Data> bigdata = [];

  u_Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      bigdata.add(Data.fromJson(v));
    });
  }
}

class Data {
  int? id;
  late F_Product product;

  Data({this.id, required this.product});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        (json['product'] != null ? F_Product.fromJson(json['product']) : null)!;
  }
}

class F_Product {
  int id = 0;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  F_Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
