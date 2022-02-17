import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  String productID;
  String name;
  double price;
  num quantity;
  String productDetails;

  Product({
    required this.productID,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productDetails,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
