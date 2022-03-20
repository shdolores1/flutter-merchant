import 'package:equatable/equatable.dart';
import 'package:flutter_merchant/models/responses/product.dart';

class ProductViewModel extends Equatable {
  final String productID;
  final String name;
  final double price;
  final num quantity;
  final String productDetails;

  const ProductViewModel({
    required this.productID,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productDetails,
  });

  factory ProductViewModel.fromResponse(Product response) {
    final String productID = response.productID ?? '';
    final String name = response.name ?? '';
    final double price = response.price ?? 0;
    final num quantity = response.quantity ?? 0;
    final String productDetails = response.productDetails ?? '';

    return ProductViewModel(
      productID: productID,
      name: name,
      price: price,
      quantity: quantity,
      productDetails: productDetails,
    );
  }

  @override
  List<Object?> get props => [
        productID,
        name,
        price,
        quantity,
        productDetails,
      ];
}
