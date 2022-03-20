import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_merchant/firebase_options.dart';
import 'package:flutter_merchant/locators/service_locator.dart';
import 'package:flutter_merchant/screens/auth/bloc.dart';
import 'package:flutter_merchant/screens/home/widget.dart';
import 'package:flutter_merchant/screens/login/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_merchant/screens/products/add_product/widget.dart';
import 'package:flutter_merchant/screens/products/update_product/widget.dart';
import 'package:flutter_merchant/screens/registration/widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.get<AuthBloc>(),
      child: MaterialApp(
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomeScreen();
              }
              return Login();
            }),
        routes: {
          Login.routeName: (ctx) => Login(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          UpdateProductScreen.routeName: (ctx) => UpdateProductScreen(),
        },
      ),
    );
  }
}
