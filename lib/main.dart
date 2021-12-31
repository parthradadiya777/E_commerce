import 'package:e_commerce/Screens/main_page.dart';
import 'package:e_commerce/Screens/product/details.dart';
import 'package:e_commerce/Screens/product/products.dart';
import 'package:e_commerce/admin/admin.dart';
import 'package:e_commerce/utility/custom.dart';
import 'package:e_commerce/profileinitpage.dart';
import 'package:e_commerce/login.dart';
import 'package:e_commerce/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: white, fontFamily: 'roboto-black'),
      home: Splash(),
      routes: {
        Splash.id: (context) => Splash(),
        Login.id: (context) => Login(),
        ProfileInitpage.id: (context) => ProfileInitpage(),
        MainPage.id: (context) => MainPage(),
        AdminScreen.id: (context) => AdminScreen(),
        ProductPage.id: (contex) => ProductPage(),
        ProductDetails.id: (context) => ProductDetails(),
      },
    );
  }
}
