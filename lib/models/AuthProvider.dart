import 'package:e_commerce/Screens/main_page.dart';
import 'package:e_commerce/models/usermodel.dart';
import 'package:e_commerce/profileinitpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider {
  // ignore: missing_return
  Future<bool> loginwithPhone(BuildContext context, String phone) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    TextEditingController otp = TextEditingController();
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential credential) async {
          UserCredential result = await _auth.signInWithCredential(credential);
          Navigator.pop(context);
          User user = result.user;
          if (user != null) {
            AppUser.set(phone);
            Navigator.pushReplacementNamed(context, MainPage.id);
          } else {
            Fluttertoast.showToast(msg: 'User Does not Exit');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: e.toString());
        },
        codeSent: (String verification, int token) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Enter OTP'),
                  content: Column(
                    children: [
                      TextField(
                        controller: otp,
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        final code = otp.text;
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verification, smsCode: code);
                        UserCredential result =
                            await _auth.signInWithCredential(credential);
                        User user = result.user;
                        if (user != null) {
                          AppUser.set(phone);
                          Navigator.pushReplacementNamed(
                              context, ProfileInitpage.id);
                          print('SUCESS');
                        } else {
                          Fluttertoast.showToast(msg: 'Error');
                        }
                      },
                      child: Text('Verify'),
                    ),
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (id) => {});
  }
}
