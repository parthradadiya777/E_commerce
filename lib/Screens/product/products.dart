import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screens/product/details.dart';
import 'package:e_commerce/utility/custom.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductPage extends StatelessWidget {
  static const id = '/product';
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var category = data["category"];

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )),
      ),
      body: StreamBuilder(
        stream: db
            .collection('products')
            .where("category", isEqualTo: category)
            .snapshots(),
        builder: (contex, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(msg: 'some missing');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final values = snapshot.data.docs;
          return values.length > 0
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProductDetails.id, arguments: {
                            "productName": values[index]['productNamec'],
                            "descriptions": values[index]['details'],
                            "brand": values[index]['brandc'],
                            "imgurl": values[index]['imgurl'],
                            "isonsale": values[index]['isonsale'],
                            "ispopular": values[index]['ispopular'],
                            "pricec": values[index]['pricec'],
                            "serialnc": values[index]['serialnc'],
                            "weightc": values[index]['weightc'],
                            'quntityc': values[index]['quntityc'],
                          }
                          );
                        },
                        child: Container(
                          decoration: decoration,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                    image: CachedNetworkImageProvider(
                                  values[index]['imgurl'][0],
                                )),

                                // child: Image.network(
                                //   values[index]['imgurl'][0],
                                //   fit: BoxFit.cover,
                                //   height: 300,
                                //   width: 200,
                                // ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                top: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          values[index]['productNamec'],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          icon: Icon(
                                            FontAwesomeIcons.cartPlus,
                                            color: white,
                                            size: 20,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No data Found'),
                );
        },
      ),
    );
  }
}
