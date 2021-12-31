import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Carousal {
  String image;
  String text;

  Carousal(this.image, this.text);
}

List carousal = [
  Carousal(
    "https://media.istockphoto.com/photos/colorful-vegetables-and-fruits-vegan-food-in-rainbow-colors-picture-id1284690585?b=1&k=20&m=1284690585&s=170667a&w=0&h=HlEPBNsYMVuu-SsohPliBWHJy-IhW9y-fl8dS9KnBBo=",
    'Vegetables',
  ),
  Carousal(
    "https://media.istockphoto.com/photos/lipsticks-picture-id1227414534?b=1&k=20&m=1227414534&s=170667a&w=0&h=b3_lSpyVUu0aAqBlrxl7Ansri_3J8wk0vUq_1LIISxo=",
    'Beuty Products',
  ),
  Carousal(
    "https://media.istockphoto.com/photos/holding-weight-and-sitting-picture-id1277242852?b=1&k=20&m=1277242852&s=170667a&w=0&h=JRJsVDFKO_i9omBAMNySqCfwvRTB-yeVrjJY2jd7JZw=",
    'Gym Accessories',
  ),
  Carousal(
    "https://images.unsplash.com/photo-1631729597135-7ddae16fb35c?ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDEyfEo5eXJQYUhYUlFZfHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    'Watch',
  ),
  Carousal(
    "https://images.unsplash.com/photo-1579547649986-36c561b127c5?ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NXw5NDE1MjA2fHxlbnwwfHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    'Electronics',
  ),
  Carousal(
    "https://media.istockphoto.com/photos/stack-of-dictionaries-isolated-picture-id520294967?b=1&k=20&m=520294967&s=170667a&w=0&h=wd9DUmZsWKEvzZBuo1GP3ZmQVhQYbtUkcgmOVaJD2nI=",
    'Books',
  ),
];

class Category {
  String title;
  IconData icon;

  Category({this.title, this.icon});
}

List category = [
  Category(title: 'Accessories', icon: FontAwesomeIcons.tshirt),
  Category(title: 'AutoMobile', icon: FontAwesomeIcons.car),
  Category(title: 'Beauty and Health', icon: FontAwesomeIcons.hatCowboy),
  Category(
      title: 'Business and Industrial', icon: FontAwesomeIcons.cashRegister),
  Category(title: 'Books and Learning', icon: FontAwesomeIcons.book),
  Category(title: 'Computer And Peripherals', icon: FontAwesomeIcons.laptop),
  Category(title: 'Electronics', icon: FontAwesomeIcons.tv),
];

displayMessage(String msg) {
  Fluttertoast.showToast(msg: msg);
}
