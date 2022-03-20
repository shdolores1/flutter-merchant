import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/screens/auth/bloc.dart';
import 'package:flutter_merchant/screens/home/widget.dart';
import 'package:flutter_merchant/screens/registration/widget.dart';

class Login extends StatefulWidget {
  static const routeName = '/login-screen';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthBloc _authBloc = ServiceLocator.get<AuthBloc>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordHide() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() {
    _authBloc.add(
      LoginRequested(_emailController.text, _passwordController.text),
    );
  }

  String? _validatePassword(String value) {
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
    super.dispose();
  }

  void _goToRegistrationScreen() {
    Navigator.of(context).pushNamed(RegistrationScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
          if (state is AuthenticationError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is Unauthenticated) {
              return Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: mediaQuery.size.height / 2),
                    decoration: MerchantDecoration.loginBgDecoration,
                  ),
                  Center(
                    child: Container(
                      //alignment: AlignmentDirectional(0.0, 0.0),
                      height: mediaQuery.size.height / 1.4,
                      width: mediaQuery.size.width - 80,
                      padding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                      decoration: MerchantDecoration.cardDecoration,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Login Account",
                              style: MerchantTextStyle.greetingsText,
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
                              obscureText: _obscureText,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Password",
                                labelStyle: MerchantTextStyle.labelText,
                                errorMaxLines: 3,
                                border: MerchantDecoration.outlineBorder,
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
                              validator: (value) {
                                return _validatePassword(value!);
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  _login();
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
                                "Login",
                                textAlign: TextAlign.center,
                                style: MerchantTextStyle.buttonText,
                              ),
                            ),
                            SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                style: MerchantTextStyle.labelText.copyWith(
                                  color: MerchantColors.black,
                                ),
                                text: "No Account? ",
                                children: [
                                  TextSpan(
                                    text: "Register",
                                    style: MerchantTextStyle.labelText,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _goToRegistrationScreen();
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
