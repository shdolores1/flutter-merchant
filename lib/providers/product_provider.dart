import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/api_endpoints.dart';
import 'package:flutter_merchant/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _productList = [];

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse(API_ENDPOINT_PRODUCTS + '/'));
      Iterable responseData = json.decode(response.body);
      _productList = List<Product>.from(
          responseData.map((object) => Product.fromJson(object)));
      return _productList;
    } catch (exception) {
      debugPrint("Exception in getting all products");
      debugPrint(exception.toString());
      throw exception;
    }
  }

  Future<Product> getProductByID(String productID) async {
    try {
      final response =
          await http.get(Uri.parse(API_ENDPOINT_PRODUCTS + '/' + productID));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      Product product = Product.fromJson(extractedData);
      return product;
    } catch (exception) {
      debugPrint("Exception in getting product by ID");
      debugPrint(exception.toString());
      throw exception;
    }
  }

  Future<void> addProduct(Product product) async {
    final requestBody = jsonEncode(product.toJson());
    try {
      final response = await http.post(Uri.parse(API_ENDPOINT_PRODUCTS),
          body: requestBody,
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      Product product = Product.fromJson(extractedData);
      _productList.add(product);
      notifyListeners();
    } catch (exception) {
      debugPrint("Exception in adding products");
      debugPrint(exception.toString());
      throw exception;
    }
  }

  Future<void> updateProduct(Product product) async {
    final productID = product.productID;
    final requestBody = jsonEncode(product.toJson());
    try {
      final response = await http.patch(
          Uri.parse(API_ENDPOINT_PRODUCTS + '/' + productID),
          body: requestBody,
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      Product product = Product.fromJson(extractedData);
      var index = _productList
          .indexWhere((element) => element.productID == product.productID);
      _productList[index] = product;
      notifyListeners();
    } catch (exception) {
      debugPrint("Exception in updating products");
      debugPrint(exception.toString());
      throw exception;
    }
  }

  Future<void> deleteProduct(String productID) async {
    final requestBody = jsonEncode({"isDeleted": true});
    try {
      final response = await http.patch(
          Uri.parse(API_ENDPOINT_PRODUCTS + '/' + productID),
          body: requestBody,
          headers: <String, String>{
            'Content-Type': 'application/json',
          });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      Product product = Product.fromJson(extractedData);
      _productList
          .removeWhere((element) => element.productID == product.productID);
      notifyListeners();
    } catch (exception) {
      debugPrint("Exception in deleting products");
      debugPrint(exception.toString());
      throw exception;
    }
  }
}
