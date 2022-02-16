import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/widgets/common_dialog.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration-screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePasswordText = true;
  bool _obscureConfirmPasswordText = true;

  Future _register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      debugPrint("Registered");

      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context) =>
            CommonDialog("Success!", "You have registered successfully."),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            CommonDialog("Oops!", e.message.toString()),
      );
    }
  }

  String? _validatePassword(String value) {
    /* Password regex pattern to check if the password contains the following: 
      (?=.*[A-Za-z]) -> Must contain at least one letter.
      (?=.*\d)       -> Must contain at least one number.
      [A-Za-z\d]     -> Any alphabetic or numeric characters only. 
      {8,30}         -> Minimum of 8 and maximum of 30 characters only.
    */
    final validCharacters = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,30}$");
    if (value.isEmpty) {
      return 'Please input a password.';
    } else if (!validCharacters.hasMatch(value)) {
      return 'Password must contain at least 1 letter, 1 number, with a minimum of 8 characters.';
    } else if (value.length > 30) {
      return 'Please input up to 30 characters only.';
    } else {
      return null;
    }
  }

  String? _validateEmail(String value) {
    final validCharacters = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (value.isEmpty) {
      return 'Please input a valid email address.';
    } else if (!validCharacters.hasMatch(value)) {
      return 'Invalid email format';
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: MerchantColors.black,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: mediaQuery.size.width,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Registration',
                  style: MerchantTextStyle.greetingsText,
                ),
                Text(
                  "Fill in the necessary details",
                  style: MerchantTextStyle.subHeaderText.copyWith(
                    color: MerchantColors.black,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: MerchantTextStyle.labelText,
                    border: MerchantDecoration.outlineBorder,
                  ),
                  validator: (value) {
                    return _validateEmail(value!);
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  obscureText: _obscurePasswordText,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: MerchantTextStyle.labelText,
                    border: MerchantDecoration.outlineBorder,
                    errorMaxLines: 2,
                    suffixIcon: IconButton(
                      iconSize: 18,
                      onPressed: () {
                        setState(() {
                          _obscurePasswordText = !_obscurePasswordText;
                        });
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.visibility,
                        color: _obscurePasswordText
                            ? MerchantColors.grey
                            : MerchantColors.blue,
                      ),
                    ),
                  ),
                  validator: (value) {
                    return _validatePassword(value!);
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPasswordText,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: MerchantTextStyle.labelText,
                    border: MerchantDecoration.outlineBorder,
                    errorMaxLines: 2,
                    suffixIcon: IconButton(
                      iconSize: 18,
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPasswordText =
                              !_obscureConfirmPasswordText;
                        });
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(
                        Icons.visibility,
                        color: _obscureConfirmPasswordText
                            ? MerchantColors.grey
                            : MerchantColors.blue,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return "Passwords does not match";
                    } else {
                      return _validatePassword(value!);
                    }
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: MerchantDecoration.cardListDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Password must contain:",
                          style: MerchantTextStyle.subHeaderText.copyWith(
                            color: MerchantColors.black,
                          ),
                        ),
                        Text(
                          "- At least one letter",
                          style: MerchantTextStyle.subHeaderText.copyWith(
                            color: MerchantColors.black,
                          ),
                        ),
                        Text(
                          "- At least one number",
                          style: MerchantTextStyle.subHeaderText.copyWith(
                            color: MerchantColors.black,
                          ),
                        ),
                        Text(
                          "- Any alphanumeric characters only",
                          style: MerchantTextStyle.subHeaderText.copyWith(
                            color: MerchantColors.black,
                          ),
                        ),
                        Text(
                          "- Minimum of 8 and maximum of 30 characters only",
                          style: MerchantTextStyle.subHeaderText.copyWith(
                            color: MerchantColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                      _register();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MerchantColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    minimumSize: Size.fromHeight(50),
                  ),
                  child: Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: MerchantTextStyle.buttonText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
