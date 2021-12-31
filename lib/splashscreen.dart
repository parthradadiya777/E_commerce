import 'dart:async';
import 'package:e_commerce/Screens/main_page.dart';
import 'package:e_commerce/login.dart';
import 'package:e_commerce/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Splash();
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Login();
          } else if (snapshot.data.phoneNumber != null) {
            AppUser.set(snapshot.data.phoneNumber);
          }
          return Splash();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  static const id = '/splash';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer _timer;

  @override
  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, MainPage.id);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.asset('image/shop.jpg'),
            ),
          ),
          Text('Shopping',
              style: TextStyle(fontFamily: 'roboto-bold', fontSize: 30)),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
