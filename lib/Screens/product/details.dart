import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utility/constant.dart';

import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';

class ProductDetails extends StatefulWidget {
  static const id = '/productDetails';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedIndex = 0;
  int itemcount = 0;

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context).settings.arguments as Map<dynamic, dynamic>;

    var productName = data['productName'];
    var descriptions = data['descriptions'];
    var brand = data['brand'];
    List imgurl = data['imgurl'];
    var isonsale = data['isonsale'];
    var ispopular = data['ispopular'];
    var pricec = data['pricec'];
    var serialnc = data['serialnc'];
    var weightc = data['weightc'];
    var quntityc = data['quntityc'];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image(
                    image: CachedNetworkImageProvider(
                      imgurl[selectedIndex],
                    ),
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  // Image.network(
                  //   imgurl[selectedIndex],
                  //   height: 300,
                  //   fit: BoxFit.cover,
                  // ),
                  Positioned(
                      top: 20,
                      left: 0,
                      child: Container(
                        color: Colors.blue,
                        height: 20,
                        width: 20,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,
                                color: Colors.black)),
                      )),
                  Positioned(
                    bottom: -10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// ... called combined two list
                        /// for example,
                        ///  a = [1,2,3,];
                        /// b = [...a,4,5,6,],
                        /// output = [1,2,3,4,5,6]; so that ... use for combined two list.

                        ...List.generate(imgurl.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });

                                print(index);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.deepOrange,
                                      )),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image(
                                      image: CachedNetworkImageProvider(
                                        imgurl[index],
                                      ),
                                      height: 50,
                                      width: 40,
                                      fit: BoxFit.contain,
                                    ),

                                    // child: Image.network(
                                    //   imgurl[index],
                                    //   height: 50,
                                    //   width: 40,
                                    //   // fit: BoxFit.contain,
                                    // ),
                                  )),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: Offset(3, 3),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5,
                                spreadRadius: 5,
                                offset: Offset(3, 3),
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                productName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 5,
                                      spreadRadius: 5,
                                      offset: Offset(3, 3),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FavoriteButton(
                                  valueChanged: (_isFavorite) {
                                    print('Is Favorite $_isFavorite)');
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              descriptions,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        spreadRadius: 5,
                        offset: Offset(3, 3),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        isonsale ? 'ON SALE' : 'OUT OF STOCK',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        'Just Only : ${pricec} RS.',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
              MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return StatefulBuilder(
                            builder: (contex, StateSetter setter) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Purchase ${productName}'.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.deepPurple),
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text('Enter Quntity'),
                                          Text('Max $quntityc')
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (itemcount >= quntityc) {
                                              displayMessage(
                                                  'You can not Exceed this limit');
                                            } else {
                                              itemcount++;
                                            }
                                          });
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                      Text('$itemcount'),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (itemcount >= 0) itemcount--;
                                          });
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Confirm')),
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Cancel')),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
