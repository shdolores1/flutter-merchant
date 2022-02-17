import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/widgets/add_product_section.dart';
import 'package:flutter_merchant/widgets/header_section.dart';
import 'package:flutter_merchant/widgets/products_section.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          decoration: MerchantDecoration.loginBgDecoration,
          width: mediaQuery.size.width,
          child: Column(
            children: <Widget>[
              HeaderSection(),
              AddProductSection(),
              ProductsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
