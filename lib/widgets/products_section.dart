import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/main.dart';
import 'package:flutter_merchant/models/product.dart';
import 'package:flutter_merchant/providers/product_provider.dart';
import 'package:flutter_merchant/widgets/common_dialog.dart';
import 'package:flutter_merchant/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductsSection extends StatefulWidget {
  @override
  _ProductsSectionState createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> with RouteAware {
  bool _isLoading = true;
  List<Product> _productList = List.empty();

  Future<void> _initProducts() async {
    try {
      _productList =
          Provider.of<ProductProvider>(context, listen: false).products;
      setState(() {
        _isLoading = false;
      });
      /*
      Provider.of<ProductProvider>(context, listen: false)
          .getAllProducts()
          .then((value) {
        setState(() {
          _productList = value;
          _isLoading = false;
        });
      });
      */
    } catch (error) {
      print('Error: ' + error.toString());
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) => CommonDialog("Oops!",
            "There was an error while loading your products. Please try again."),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _initProducts());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height / 1.3,
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
          Divider(),
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
                  :
                  // Column(
                  //     children: <Widget>[
                  //       ..._productList
                  //           .map((product) => ProductCard(
                  //                 product: product,
                  //               ))
                  //           .toList()
                  //     ],
                  //   ),
                  Consumer<ProductProvider>(
                      builder: (context, provider, listTile) {
                      return Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: _productList.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                product: _productList[index],
                              );
                            },
                          ),
                        ),
                      );
                    }),
        ],
      ),
    );
  }
}
