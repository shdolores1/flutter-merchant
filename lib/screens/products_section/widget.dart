import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/screens/products_section/bloc.dart';
import 'package:flutter_merchant/widgets/common_dialog.dart';
import 'package:flutter_merchant/widgets/product_card.dart';

class ProductsSection extends StatefulWidget {
  @override
  _ProductsSectionState createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> with RouteAware {
  final ProductsSectionBloc _productsSectionBloc =
      ServiceLocator.get<ProductsSectionBloc>();

  @override
  void initState() {
    super.initState();
    _productsSectionBloc.add(ProductsSectionLoadStarted());
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height / 1.3,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      margin: EdgeInsets.only(top: 20),
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
          BlocBuilder<ProductsSectionBloc, ProductsSectionState>(
            bloc: _productsSectionBloc,
            builder: (context, state) {
              if (state is ProductsSectionInitial) {
                return const Text(
                  "No available products yet.",
                  style: TextStyle(color: Colors.grey),
                );
              }

              if (state is ProductsSectionLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProductsSectionLoaded) {
                final products = state.products;
                return Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: products[index],
                        );
                      },
                    ),
                  ),
                );
              }

              if (state is ProductsSectionFailure) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      CommonDialog("Oops!", state.message.toString()),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
