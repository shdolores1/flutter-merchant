import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/api_endpoints.dart';
import 'package:flutter_merchant/models/responses/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  List<Product> _productList = [];

  String getProductApiEndpoint() {
    if (kIsWeb) {
      return (WEB_SERVER_URL + API_ENDPOINT_PRODUCTS);
    } else {
      return (ANDROID_SERVER_URL + API_ENDPOINT_PRODUCTS);
    }
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(getProductApiEndpoint() + '/'));
      Iterable responseData = json.decode(response.body);
      // _productList = List<Product>.from(
      //     responseData.map((object) => Product.fromJson(object)));
      // return _productList;
      return List<Product>.from(
          responseData.map((object) => Product.fromJson(object)));
    } catch (exception) {
      debugPrint("Exception in getting all products");
      debugPrint(exception.toString());
      throw exception;
    }
  }

  Future<Product> getProductByID(String productID) async {
    try {
      final response =
          await http.get(Uri.parse(getProductApiEndpoint() + '/' + productID));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      Product product = Product.fromJson(extractedData);
      return product;
    } catch (exception) {
      debugPrint("Exception in getting product by ID");
      debugPrint(exception.toString());
      throw exception;
    }
  }

  Future<Product> addProduct(
    String productID,
    String name,
    double price,
    num quantity,
    String productDetails,
  ) async {
    Product product = new Product(
      productID: productID,
      name: name,
      price: price,
      quantity: quantity,
      productDetails: productDetails,
    );

    final requestBody = jsonEncode(product.toJson());
    try {
      final response = await http.post(Uri.parse(getProductApiEndpoint()),
          body: requestBody,
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      return Product.fromJson(extractedData);
    } catch (exception) {
      debugPrint("Exception in adding products");
      debugPrint(exception.toString());
      throw exception;
    }
  }

  Future<Product> updateProduct(
    String productID,
    String name,
    double price,
    num quantity,
    String productDetails,
  ) async {
    Product product = new Product(
      productID: productID,
      name: name,
      price: price,
      quantity: quantity,
      productDetails: productDetails,
    );
    final requestBody = jsonEncode(product.toJson());
    try {
      final response = await http.patch(
          Uri.parse(getProductApiEndpoint() + '/' + productID),
          body: requestBody,
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // Product product = Product.fromJson(extractedData);
      // var index = _productList
      //     .indexWhere((element) => element.productID == product.productID);
      // _productList[index] = product;
      return Product.fromJson(extractedData);
    } catch (exception) {
      debugPrint("Exception in updating products");
      debugPrint(exception.toString());
      throw exception;
    }
  }

  Future<Product> deleteProduct(String productID) async {
    final requestBody = jsonEncode({"isDeleted": true});
    try {
      final response = await http.patch(
          Uri.parse(getProductApiEndpoint() + '/' + productID),
          body: requestBody,
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // Product product = Product.fromJson(extractedData);
      // _productList
      //     .removeWhere((element) => element.productID == product.productID);
      return Product.fromJson(extractedData);
    } catch (exception) {
      debugPrint("Exception in deleting products");
      debugPrint(exception.toString());
      throw exception;
    }
  }
}
