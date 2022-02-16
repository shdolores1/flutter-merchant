import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';

class HeaderSection extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser ?? null;

  void _logout() {
    try {
      FirebaseAuth.instance.signOut();
      debugPrint("Logged out");
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40, bottom: 10, left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'My Store',
                style: MerchantTextStyle.greetingsText.copyWith(
                  color: MerchantColors.white,
                ),
              ),
              Text(
                "Signed in as ${user?.email}",
                style: MerchantTextStyle.subHeaderText.copyWith(
                  color: MerchantColors.white,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: _logout,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 50),
            ),
            child: Icon(
              Icons.logout,
              color: MerchantColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
