import 'package:e_commerce/Screens/Drawer.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utility/constant.dart';
import 'package:e_commerce/utility/custom.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class AdminScreen extends StatefulWidget {
  static const id = '/admin';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController catagoryc = TextEditingController();
  TextEditingController productNamec = TextEditingController();
  TextEditingController serialnc = TextEditingController();
  TextEditingController pricec = TextEditingController();
  TextEditingController weightc = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController quntityc = TextEditingController();
  TextEditingController onSalec = TextEditingController();
  TextEditingController popularc = TextEditingController();
  TextEditingController details = TextEditingController();

  bool ispopular = false;
  bool issale = false;

  GlobalKey<FormState> key2 = GlobalKey<FormState>();

  List<Asset> images = <Asset>[];
  List<String> imageurl = <String>[];

  save() async {
    bool isvalide = key2.currentState.validate();
    if (isvalide) {
      await uplodedImages();
      ProductModel().addproduct(
        ProductModel(
          category: catagoryc.text,
          productNamec: productNamec.text,
          details: details.text,
          serialnc: serialnc.text,
          pricec: int.parse(pricec.text),
          weightc: double.parse(weightc.text),
          brandname: brand.text,
          quntityc: double.parse(quntityc.text),
          imgurl: imageurl,
          isonsale: issale,
          ispopular: ispopular,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Form(
        key: key2,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
                child: DropdownButtonFormField(
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Should not be empty';
                    }
                    return null;
                  },
                  hint: Text('select category'),
                  decoration: InputDecoration(border: InputBorder.none),
                  value: category[0].title,
                  onChanged: (v) {
                    catagoryc.text = v;
                    print(catagoryc);
                  },
                  items: category
                      .map((e) => DropdownMenuItem(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(e.title),
                            ),
                            value: e.title,
                          ))
                      .toList(),
                ),
              ),
            ),
            FormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Should not be empty';
                }
                return null;
              },
              hinttext: 'Enter Product Name',
              controller: productNamec,
              onsubmit: (value) {
                setState(() {
                  productNamec.text = value;
                });
              },
            ),
            FormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Should not be empty';
                }
                return null;
              },
              hinttext: 'Enter Product Details',
              lines: 5,
              controller: details,
              onsubmit: (value) {
                setState(() {
                  details.text = value;
                });
              },
            ),
            FormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Should not be empty';
                }
                return null;
              },
              hinttext: 'Enter Serial Number',
              controller: serialnc,
              onsubmit: (value) {
                setState(() {
                  serialnc.text = value;
                });
              },
            ),
            FormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Should not be empty';
                }
                return null;
              },
              hinttext: 'Enter Product Price',
              controller: pricec,
              onsubmit: (value) {
                setState(() {
                  pricec.text = value;
                });
              },
            ),
            FormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Should not be empty';
                }
                return null;
              },
              hinttext: 'Enter Product Weight',
              controller: weightc,
              onsubmit: (value) {
                setState(() {
                  weightc.text = value;
                });
              },
            ),
            FormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Should not be empty';
                }
                return null;
              },
              hinttext: 'Enter Brand Name',
              controller: brand,
              onsubmit: (value) {
                setState(() {
                  brand.text = value;
                });
              },
            ),
            FormField(
              validator: (v) {
                if (v.isEmpty) {
                  return 'Should not be empty';
                }
                return null;
              },
              hinttext: 'Enter Product Quntity',
              controller: quntityc,
              onsubmit: (value) {
                setState(() {
                  quntityc.text = value;
                });
              },
            ),
            Container(
              height: 250,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      loadAsset();
                    },
                    child: Text('Pick Images'),
                  ),
                  Expanded(
                    child: builderView(),
                  ),
                ],
              ),
            ),
            SwitchListTile(
                title: Text('is this on Sale'),
                value: issale,
                onChanged: (v) {
                  setState(() {
                    issale = v;
                  });
                }),
            SwitchListTile(
              title: Text('is this on Popular'),
              value: ispopular,
              onChanged: (v) {
                setState(() {
                  ispopular = v;
                });
              },
            ),
            MaterialButton(
              shape: StadiumBorder(),
              onPressed: () {
                save();
              },
              child: Text('Upload Product', style: heading1),
              color: primarycolor,
            ),
          ],
        ),
      ),
    );
  }

  loadAsset() async {
    List<Asset> resultImages = <Asset>[];
    String error = "Something Wents wrong";
    try {
      resultImages = await MultiImagePicker.pickImages(
          maxImages: 5, enableCamera: true, selectedAssets: images);

      setState(() {
        images = resultImages;
      });
    } catch (e) {
      error = e.toString();
      print(error);
    }
  }

  Future postImage(Asset image) async {
    String filename = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseStorage db = FirebaseStorage.instance;

    await db
        .ref()
        .child('images')
        .child(filename)
        .putData((await image.getByteData()).buffer.asUint8List());

    return db.ref().child('images').child(filename).getDownloadURL();
  }

  uplodedImages() async {
    for (var image in images) {
      await postImage(image)
          .then((downloadurl) => {imageurl.add(downloadurl.toString())})
          .catchError((e) {
        print(e.toString());
      });
    }
  }

  Widget builderView() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: images.length == 0
          ? IconButton(icon: Icon(Icons.add), onPressed: () {})
          : GridView.count(
              crossAxisSpacing: 3,
              mainAxisSpacing: 2,
              crossAxisCount: 2,
              children: List.generate(
                images.length,
                (index) {
                  Asset asset = images[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child:
                            AssetThumb(asset: asset, width: 150, height: 150)),
                  );
                },
              ),
            ),
    );
  }
}

class FormField extends StatelessWidget {
  final String hinttext;
  final TextEditingController controller;
  final Function onsubmit;
  final Function validator;
  final int lines;

  FormField({this.hinttext, this.controller, this.onsubmit, this.validator,this.lines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            maxLines: lines,
            validator: validator,
            onFieldSubmitted: onsubmit,
            controller: controller,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hinttext),
          ),
        ),
      ),
    );
  }
}
