import 'package:e_commerce/Screens/product/products.dart';
import 'package:e_commerce/Widgets/Silder.dart';
import 'package:e_commerce/login.dart';
import 'package:e_commerce/models/usermodel.dart';
import 'package:e_commerce/profileinitpage.dart';
import 'package:e_commerce/utility/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Drawer.dart';

class MainPage extends StatefulWidget {
  static const id = '/mainpage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List newlist = List.from(category);

  TextEditingController search;
  GlobalKey key = GlobalKey<FormState>();

  // @override
  // void initState() {
  //   super.initState();
  //   go();
  // }

  @override
  void dispose() {
    search.clear();
    super.dispose();
  }

  AppUser appUser = AppUser();

  @override
  void didChangeDependencies() async {
    if (await appUser.getInfoformdb) {
      if (!AppUser.isloggined) {
        Navigator.pushReplacementNamed(context, Login.id);
      } else {
        Navigator.pushReplacementNamed(context, ProfileInitpage.id);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(title: Text('Home Page'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Form(
                    key: key,
                    child: TextFormField(
                      keyboardAppearance: Brightness.dark,
                      cursorHeight: 20,
                      cursorColor: Colors.deepPurple,
                      controller: search,
                      onChanged: (v) {
                        setState(() {
                          search.text = v;
                          newlist = category
                              .where(
                                (e) => e.title.toLowerCase().contains(
                                      v.toLowerCase(),
                                    ),
                              )
                              .toList();
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search here.....',
                        suffixIcon: Icon(FontAwesomeIcons.accusoft),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Cslider(),
              SizedBox(
                height: 20,
              ),
              Text(
                'CATEGORY',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Column(
                children: newlist
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(ProductPage.id, arguments: {
                                "category": e.title,
                                "icon": e.icon,
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [Colors.purple, Colors.blue],
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Text(
                                        e.title,
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Icon(
                                        e.icon,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
