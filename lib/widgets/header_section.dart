import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'My Store',
            style: MerchantTextStyle.greetingsText.copyWith(
              color: MerchantColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
