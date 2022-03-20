import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/models/view_models/product_view_model.dart';
import 'package:flutter_merchant/screens/products/update_product/widget.dart';
import 'package:flutter_merchant/screens/products_section/bloc.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  final ProductViewModel? product;

  ProductCard({this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final ProductsSectionBloc _productsSectionBloc =
      ServiceLocator.get<ProductsSectionBloc>();
  final currency = new NumberFormat.currency(
      locale: "en_PH", name: "PHP", symbol: "₱", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(UpdateProductScreen.routeName,
                arguments: widget.product?.productID)
            .then((value) {
          debugPrint("Reload product section");
          Future.delayed(Duration(milliseconds: 100), () {
            _productsSectionBloc.add(ProductsSectionLoadStarted());
          });
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: MerchantDecoration.cardListDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: MerchantColors.light_blue,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Text(
                        "${widget.product?.name}",
                        style: MerchantTextStyle.headerText
                            .copyWith(color: MerchantColors.black),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Text(
                        "Quantity: ${widget.product?.quantity}",
                        style: MerchantTextStyle.subHeaderText
                            .copyWith(color: MerchantColors.black),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Text(
                        "${widget.product?.productDetails}",
                        style: MerchantTextStyle.subHeaderText
                            .copyWith(color: MerchantColors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              currency.format(widget.product!.price),
              style: MerchantTextStyle.headerText
                  .copyWith(color: MerchantColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
