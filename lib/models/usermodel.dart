import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  static String name;
  static String phone;
  static String house;
  static String street;
  static String city;
  static String zipcode;
  static String dob;
  static String fcmtocken;
  static bool isloggined;
  static int usertype;

  FirebaseFirestore db = FirebaseFirestore.instance;

  static void set(String phone) {
    AppUser.name = '';
    AppUser.phone = phone;
    AppUser.house = '';
    AppUser.street = '';
    AppUser.city = '';
    AppUser.zipcode = '';
    AppUser.isloggined = false;
    AppUser.usertype = 0;
  }

  Map<String, dynamic> get getMap {
    return {
      'name': AppUser.name,
      'phone': AppUser.phone,
      'house': AppUser.house,
      'street': AppUser.street,
      'city': AppUser.city,
      'zipcode': AppUser.zipcode,
      'usertype': AppUser.usertype,
    };
  }

  static void update({
    String name,
    String phone,
    String house,
    String street,
    String city,
    String zipcode,
    String dob,
    String fcmtocken,
    bool isloggined,
    int usertype,
  }) {
    AppUser.name = name;
    AppUser.phone = phone;
    AppUser.house = house;
    AppUser.street = street;
    AppUser.city = city;
    AppUser.zipcode = zipcode;
    AppUser.isloggined = isloggined;
    AppUser.usertype = usertype;
  }

  get getInfoformdb async {
    var temp = false;

    var value = await db.collection('user').doc(AppUser.phone).get();

    if (value.exists) {
      temp = true;
      update(
        name: value.data()['name'],
        house: value.data()['house'],
        street: value.data()['street'],
        city: value.data()['city'],
        zipcode: value.data()['zipcode'],
        dob: value.data()['dob'],
        usertype: value.data()['usertype'],
        isloggined: AppUser.isloggined,
        fcmtocken: value.data()['fcmtocken'],
      );
      return temp;
    }
  }
}
