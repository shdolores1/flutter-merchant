import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/models/product.dart';
import 'package:flutter_merchant/screens/update_product_screen.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  final Product? product;

  ProductCard({this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final currency = new NumberFormat.currency(
      locale: "en_PH", name: "PHP", symbol: "₱", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          UpdateProductScreen.routeName,
          arguments: widget.product?.productID,
        );
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
