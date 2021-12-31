import 'package:e_commerce/Screens/main_page.dart';
import 'package:e_commerce/admin/admin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Welcome  E_commerce',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                color: Colors.deepPurple),
          ),
          draweritems(FontAwesomeIcons.home, "Home Page", () {
            Navigator.pushReplacementNamed(context, MainPage.id);
          }),
          draweritems(FontAwesomeIcons.user, "User", () {
            Navigator.pushReplacementNamed(context, AdminScreen.id);
          }),
        ],
      ),
    );
  }

  ListTile draweritems(IconData icon, String title, GestureTapCallback ontap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: ontap,
    );
  }
}
