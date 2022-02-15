import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';

class AddProductSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        width: mediaQuery.size.width - 30,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: MerchantDecoration.customBtnDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Add new product',
                  style: MerchantTextStyle.headerText
                      .copyWith(color: MerchantColors.black),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    "Specify name, quantity, price, etc.",
                    style: MerchantTextStyle.subHeaderText
                        .copyWith(color: MerchantColors.black),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.add,
              size: 30,
              color: MerchantColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
