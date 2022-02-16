// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    productID: json['productID'] as String?,
    name: json['name'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    quantity: json['quantity'] as num?,
    productDetails: json['productDetails'] as String?,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productID': instance.productID,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'productDetails': instance.productDetails,
    };
