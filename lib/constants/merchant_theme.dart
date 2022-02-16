import 'package:flutter/material.dart';

class MerchantColors {
  static const Color purple = Color.fromRGBO(69, 47, 205, 1);
  static const Color highlight_blue = Color.fromRGBO(78, 203, 244, 1);
  static const Color red = Color.fromRGBO(244, 93, 93, 1);

  static const Color light_grey = Color(0xFFC4C4C4);
  static const Color grey = Color.fromRGBO(118, 118, 118, 1);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color lightPrimaryBG = Color.fromARGB(255, 245, 245, 245);
  static const Color lightSecondaryBG = Color.fromARGB(255, 228, 228, 228);
  static const Color blue = Color(0xFF3845e7);
  static const Color light_blue = Color(0xFFC7DCFF);
}

class MerchantTextStyle {
  static const TextStyle greetingsText = TextStyle(
    color: MerchantColors.black,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle labelText = TextStyle(
    color: MerchantColors.blue,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static const TextStyle buttonText = TextStyle(
    color: MerchantColors.white,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );

  static const TextStyle headerText = TextStyle(
    color: MerchantColors.white,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const TextStyle subHeaderText = TextStyle(
    color: MerchantColors.white,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );
}

class MerchantDecoration {
  static OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: MerchantColors.blue,
      width: 2.0,
    ),
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 2),
      ),
    ],
    color: MerchantColors.white,
  );

  static BoxDecoration cardListDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 2),
      ),
    ],
    color: MerchantColors.white,
  );

  static BoxDecoration containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: MerchantColors.light_grey,
  );

  static BoxDecoration customBtnDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: MerchantColors.white,
  );

  static BoxDecoration productsSectionDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),
    color: MerchantColors.white,
  );

  static BoxDecoration loginBgDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(60),
      bottomRight: Radius.circular(60),
    ),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        MerchantColors.blue,
        MerchantColors.purple,
      ],
    ),
  );
}
