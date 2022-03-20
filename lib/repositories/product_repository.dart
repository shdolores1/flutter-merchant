import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/models/responses/product.dart';
import 'package:flutter_merchant/models/view_models/product_view_model.dart';
import 'package:flutter_merchant/services/product_service.dart';

abstract class ProductRepository {
  Future<ProductViewModel> addProduct(
    String productID,
    String name,
    double price,
    num quantity,
    String productDetails,
  );

  Future<ProductViewModel> updateProduct(
    String productID,
    String name,
    double price,
    num quantity,
    String productDetails,
  );

  Future<ProductViewModel> deleteProduct(String productID);

  Future<List<ProductViewModel>> loadProducts();

  Future<ProductViewModel> loadProduct(String productID);
}

class ProductRepositoryImpl extends ProductRepository {
  final ProductService _productService = ServiceLocator.get<ProductService>();

  @override
  Future<ProductViewModel> addProduct(
    String productID,
    String name,
    double price,
    num quantity,
    String productDetails,
  ) async {
    final Product response = await _productService.addProduct(
      productID,
      name,
      price,
      quantity,
      productDetails,
    );
    return ProductViewModel.fromResponse(response);
  }

  @override
  Future<ProductViewModel> updateProduct(
    String productID,
    String name,
    double price,
    num quantity,
    String productDetails,
  ) async {
    final Product response = await _productService.updateProduct(
      productID,
      name,
      price,
      quantity,
      productDetails,
    );
    return ProductViewModel.fromResponse(response);
  }

  @override
  Future<ProductViewModel> deleteProduct(String productID) async {
    final Product response = await _productService.deleteProduct(productID);
    return ProductViewModel.fromResponse(response);
  }

  @override
  Future<ProductViewModel> loadProduct(String productID) async {
    final Product response = await _productService.getProductByID(productID);
    return ProductViewModel.fromResponse(response);
  }

  @override
  Future<List<ProductViewModel>> loadProducts() async {
    final List<Product> response = await _productService.getAllProducts();
    final List<ProductViewModel> products = response
        .map((object) => ProductViewModel.fromResponse(object))
        .toList();
    return products;
  }
}
