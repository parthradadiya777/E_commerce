import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screens/main_page.dart';
import 'package:e_commerce/login.dart';
import 'package:e_commerce/models/usermodel.dart';
import 'package:e_commerce/utility/constant.dart';
import 'package:e_commerce/utility/custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: must_be_immutable
class ProfileInitpage extends StatefulWidget {
  // ignore: missing_return
  static const id = '/homepage';

  @override
  State<ProfileInitpage> createState() => _ProfileInitpageState();
}

class _ProfileInitpageState extends State<ProfileInitpage> {
  Future signout(BuildContext context) {
    FirebaseAuth.instance
        .signOut()
        .whenComplete(() => Navigator.pushReplacementNamed(context, Login.id));
  }

  final TextEditingController namec = TextEditingController();

  final TextEditingController housenoc = TextEditingController();

  final TextEditingController streetc = TextEditingController();

  final TextEditingController cityc = TextEditingController();

  final TextEditingController zipcodec = TextEditingController();

  final TextEditingController dobc = TextEditingController();

  DateTime selecteddate;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool isloading = false;

  submit(BuildContext context) async {
    if (formKey.currentState.validate()) {
      FirebaseMessaging fbm = FirebaseMessaging.instance;
      String fcm = await fbm.getToken();
      AppUser.update(
        name: namec.text,
        house: housenoc.text,
        street: streetc.text,
        city: cityc.text,
        zipcode: zipcodec.text,
        dob: dobc.text,
        fcmtocken: fcm,
        isloggined: true,
        usertype: 0,
      );

      db
          .collection('user')
          .doc(AppUser.phone)
          .set(AppUser().getMap)
          .then((value) {
        Navigator.of(context).pushReplacementNamed(MainPage.id);
      }).catchError((e) {
        displayMessage(e.toString());
      });

      setState(() {
        isloading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'PROFILE',
                    style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  )),
              isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 30),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        //color: Colors.grey.shade100,
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      namec.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    controller: namec,
                                    validator: (v) {
                                      if (v.length < 5) {
                                        return 'should be greater Than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      icon: person,
                                      hintText: 'Enter Name',
                                      labelText: 'What People Call You?',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      housenoc.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    controller: housenoc,
                                    validator: (v) {
                                      if (v.length < 5) {
                                        return 'should be greater Than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      icon: address,
                                      hintText: 'Enter Houseno.',
                                      labelText: 'Enter Houseno.',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      streetc.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    controller: streetc,
                                    validator: (v) {
                                      if (v.length < 5) {
                                        return 'should be greater Than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      icon: address,
                                      hintText: 'Enter Street',
                                      labelText: 'Enter Street',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      zipcodec.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    controller: zipcodec,
                                    validator: (v) {
                                      if (v.length < 4) {
                                        return 'should be greater Than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      icon: address,
                                      labelText: 'Enter Zip code',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: TextFormField(
                                    onFieldSubmitted: (v) {
                                      dobc.text = v;
                                    },
                                    textInputAction: TextInputAction.next,
                                    onTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1970),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        if (value == null) {
                                          return;
                                        } else {
                                          selecteddate = value;
                                          dobc.text = selecteddate
                                              .toString()
                                              .substring(0, 10);
                                        }
                                      });
                                    },
                                    controller: dobc,
                                    validator: (v) {
                                      if (v.length < 5) {
                                        return 'should be greater Than 5';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      icon: dob,
                                      labelText: 'Enter Date of Birth',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              isloading
                  ? null
                  : FloatingActionButton(
                      onPressed: () {
                        submit(context);
                      },
                      child: Icon(Icons.navigate_next),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
