import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/api_endpoints.dart';
import 'package:flutter_merchant/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  // List<Product> productList = List.empty();

  List<Product> _productList = [
    Product(
      productID: "1",
      name: "Hot/Iced Mocha Latte",
      quantity: 1,
      price: 120,
      productDetails: "Espresso, chocolate syrup, steamed milk ",
    ),
    Product(
      productID: "2",
      name: "Hot/Iced Mocha Latte",
      quantity: 1,
      price: 1200,
      productDetails:
          "Espresso, chocolate syrup, steamed milk Espresso, chocolate syrup, steamed milk Espresso, chocolate syrup, steamed milk ",
    ),
  ];

  List<Product> get products {
    return _productList;
  }

  void addProduct(Product product) {
    _productList.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    var index = _productList
        .indexWhere((element) => element.productID == product.productID);
    _productList[index] = product;
    notifyListeners();
  }

  void deleteProduct(String productID) {
    _productList.removeWhere((element) => element.productID == productID);
    notifyListeners();
  }

  Product getProductByID(String productID) {
    return _productList.firstWhere((element) => element.productID == productID);
  }

  Future<List<Product>> getAllProducts() async {
    try {
      var url = Uri.parse(API_ENDPOINT_PRODUCTS + '/');
      final response = await http.get(url);
      Iterable responseData = json.decode(response.body);
      _productList = List<Product>.from(
          responseData.map((object) => Product.fromJson(object)));
    } catch (exception) {
      print(exception.toString());
    }
    return _productList;
  }
}
