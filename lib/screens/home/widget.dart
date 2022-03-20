import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/screens/auth/bloc.dart';
import 'package:flutter_merchant/screens/login/widget.dart';
import 'package:flutter_merchant/screens/products_section/widget.dart';
import 'package:flutter_merchant/widgets/add_product_section.dart';
import 'package:flutter_merchant/widgets/header_section.dart';

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Login()),
              (route) => false,
            );
          }
        },
        child: SingleChildScrollView(
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
      ),
    );
  }
}
