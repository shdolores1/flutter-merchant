import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';

class CommonDialog extends StatefulWidget {
  String title, content;
  CommonDialog(this.title, this.content);
  @override
  _CommonDialogState createState() => _CommonDialogState();
}

class _CommonDialogState extends State<CommonDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      titleTextStyle:
          MerchantTextStyle.greetingsText.copyWith(color: MerchantColors.black),
      content: Text(widget.content),
      contentPadding: EdgeInsets.only(left: 24, right: 24, top: 10),
      contentTextStyle:
          MerchantTextStyle.labelText.copyWith(color: MerchantColors.black),
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
          child: Text("OK"),
        ),
      ],
    );
  }
}
