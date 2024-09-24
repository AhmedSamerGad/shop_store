class ProdectModel {
  bool? status;
  ProductData? data;
  ProdectModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = ProductData.fromjson(json['data']);
  }
}

class ProductData {
  List<Banners> banners = [];
  List<Product> products = [];
  ProductData.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((elements) {
      banners.add(Banners.formJason(elements));
    });
    json['products'].forEach((element) {
      products.add(Product.fromJason(element));
    });
  }
}

class Banners {
  int? id;
  String? image;

  Banners.formJason(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Product {
  int id = 0;
  dynamic price;
  dynamic oldPrice;
  dynamic discound;
  String? image;
  late bool inFavorite;
  bool? inCart;
  String? name;
  String? description;
  List<String> images = [];
  Product.fromJason(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discound = json['discount'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].forEach((elements) {
      images.add(elements);
    });
  }
}
