// import 'package:json_annotation/json_annotation.dart';
// part 'product.g.dart';

// @JsonSerializable()
class Product {
  String productID;
  String image;
  String name;
  double price;
  num quantity;
  String productDetails;

  Product(
    this.productID,
    this.image,
    this.name,
    this.price,
    this.quantity,
    this.productDetails,
  );

  // factory MerchantProduct.fromJson(Map<String, dynamic> json) =>
  //     _$MerchantProductFromJson(json);

  // Map<String, dynamic> toJson() => _$MerchantProductToJson(this);
}
