import 'package:flutter_merchant/repositories/auth_repository.dart';
import 'package:flutter_merchant/repositories/product_repository.dart';
import 'package:flutter_merchant/screens/auth/bloc.dart';
import 'package:flutter_merchant/screens/products/add_product/bloc.dart';
import 'package:flutter_merchant/screens/products/delete_product/bloc.dart';
import 'package:flutter_merchant/screens/products/update_product/bloc.dart';
import 'package:flutter_merchant/screens/products/view_product/bloc.dart';
import 'package:flutter_merchant/screens/products_section/bloc.dart';
import 'package:flutter_merchant/services/product_service.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final GetIt _locator = GetIt.instance;

  static Future<void> init() async {
    // Services
    _locator.registerSingleton<ProductService>(ProductService());

    // Repositories
    _locator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
    _locator.registerSingleton<ProductRepository>(ProductRepositoryImpl());

    // Blocs
    _locator.registerSingleton<AuthBloc>(AuthBloc());
    _locator.registerSingleton<AddProductBloc>(AddProductBloc());
    _locator.registerSingleton<ViewProductBloc>(ViewProductBloc());
    _locator.registerSingleton<UpdateProductBloc>(UpdateProductBloc());
    _locator.registerSingleton<DeleteProductBloc>(DeleteProductBloc());
    _locator.registerSingleton<ProductsSectionBloc>(ProductsSectionBloc());

    return _locator.allReady();
  }

  static T get<T extends Object>({dynamic param1}) =>
      _locator.get<T>(param1: param1);
}
