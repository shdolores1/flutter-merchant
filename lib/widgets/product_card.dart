import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/models/product.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  Product product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final currency = new NumberFormat.currency(
      locale: "en_PH", name: "PHP", symbol: "₱", decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).pushNamed(
        //   BookingDetailsScreen.routeName,
        //   arguments: (widget.riderType == "outsource")
        //       ? widget.transaction.transactionID
        //       : widget.booking.merchantOrderID,
        // );
      },
      child: Card(
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: MerchantColors.light_blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 20,
                      color: MerchantColors.blue,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.product.name,
                        style: MerchantTextStyle.headerText
                            .copyWith(color: MerchantColors.black),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Text(
                          widget.product.productDetails,
                          style: MerchantTextStyle.headerText
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
                currency.format(widget.product.price),
                style: MerchantTextStyle.headerText
                    .copyWith(color: MerchantColors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
