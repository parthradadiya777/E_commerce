import 'package:e_commerce/models/AuthProvider.dart';
import 'package:e_commerce/utility/custom.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const id = '/Login';
 final GlobalKey formkey = GlobalKey<FormState>();
 final TextEditingController controlor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('image/shop.jpg'),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Shopping',
                  style: TextStyle(
                    fontSize: 40,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
                child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Phone Number'),
                      controller: controlor,
                      key: formkey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    if (controlor.text != null) {
                      final phone = '+91' + controlor.text;
                      AuthProvider().loginwithPhone(context, phone);
                    }
                  },
                  color: primarycolor,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
