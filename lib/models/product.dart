import 'package:meta/meta.dart';

class Product {
  String id;
  String name;
  String description;
  num price;
  Map<String, dynamic> picture;
  String color;

  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.picture,
    @required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "picture": picture,
      "color": color
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        color: json['color'],
        description: json['description'],
        price: json['price'],
        picture: json['picture']);
  }
}
