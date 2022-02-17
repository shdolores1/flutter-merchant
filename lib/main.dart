import 'package:flutter/material.dart';
import 'package:flutter_merchant/constants/merchant_theme.dart';
import 'package:flutter_merchant/firebase_options.dart';
import 'package:flutter_merchant/providers/product_provider.dart';
import 'package:flutter_merchant/screens/add_product_screen.dart';
import 'package:flutter_merchant/screens/home_screen.dart';
import 'package:flutter_merchant/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_merchant/screens/registration_screen.dart';
import 'package:flutter_merchant/screens/update_product_screen.dart';
import 'package:flutter_merchant/widgets/common_dialog.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Merchant',
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: MerchantColors.blue,
                  ),
                );
              } else if (snapshot.hasError) {
                return CommonDialog("Oops!", snapshot.error.toString());
              } else if (snapshot.hasData) {
                return HomeScreen();
              } else {
                return LoginScreen();
              }
            }),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          UpdateProductScreen.routeName: (ctx) => UpdateProductScreen(),
        },
      ),
    );
  }
}
