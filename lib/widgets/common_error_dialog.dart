import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';

class CommonErrorDialog extends StatefulWidget {
  String title, content;
  CommonErrorDialog(this.title, this.content);
  @override
  _CommonErrorDialogState createState() => _CommonErrorDialogState();
}

class _CommonErrorDialogState extends State<CommonErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      titleTextStyle:
          MerchantTextStyle.headerText.copyWith(color: MerchantColors.black),
      content: Text(widget.content),
      contentPadding: EdgeInsets.only(left: 24, right: 24, top: 10),
      contentTextStyle:
          MerchantTextStyle.subHeaderText.copyWith(color: MerchantColors.black),
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              primary: MerchantColors.blue,
              textStyle: MerchantTextStyle.buttonText
                  .copyWith(color: MerchantColors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"))
      ],
    );
  }
}
