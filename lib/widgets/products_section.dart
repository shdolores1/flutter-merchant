import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/main.dart';
import 'package:flutter_merchant/models/product.dart';
import 'package:flutter_merchant/widgets/common_error_dialog.dart';
import 'package:flutter_merchant/widgets/product_card.dart';

class ProductsSection extends StatefulWidget {
  @override
  _ProductsSectionState createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> with RouteAware {
  bool _isLoading = true;
  List<Product> _productList = List.empty();

  Future<void> _initProducts() async {
    try {
      _isLoading = false;
    } catch (error) {
      print('Error: ' + error.toString());
      _isLoading = false;
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonErrorDialog("Oops!",
            "There was an error while loading your products. Please try again."),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initProducts();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _initProducts());
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _initProducts());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: MerchantDecoration.productsSectionDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Product List',
                style: MerchantTextStyle.greetingsText,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: MerchantColors.blue,
                  ),
                )
              : (_productList.isEmpty)
                  ? Text(
                      "No pending bookings yet.",
                      style: TextStyle(color: Colors.grey),
                    )
                  : Column(children: <Widget>[
                      ..._productList
                          .map((product) => ProductCard(
                                product: product,
                              ))
                          .toList()
                    ]),
        ],
      ),
    );
  }
}
