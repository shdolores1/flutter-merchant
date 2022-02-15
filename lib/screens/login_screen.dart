import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordHide() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      debugPrint("Logged in");
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: mediaQuery.size.height / 2),
            decoration: MerchantDecoration.loginBgDecoration,
          ),
          Center(
            child: Container(
              height: mediaQuery.size.height / 2,
              width: mediaQuery.size.width - 80,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: MerchantDecoration.cardDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login Account",
                    style: MerchantTextStyle.greetingsText,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: MerchantTextStyle.labelText,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: _obscureText,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: MerchantTextStyle.labelText,
                      suffixIcon: IconButton(
                        iconSize: 18,
                        onPressed: _togglePasswordHide,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Icon(
                          Icons.visibility,
                          color: _obscureText
                              ? MerchantColors.grey
                              : MerchantColors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(MerchantColors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size.fromHeight(50),
                      ),
                    ),
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: MerchantTextStyle.buttonText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
