import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String category;
  String productNamec;
  String details;
  String serialnc;
  int pricec;
  double weightc;
  String brandname;
  double quntityc;
  List<String> imgurl;
  bool isonsale;
  bool ispopular;

  ProductModel({
    this.category,
    this.productNamec,
    this.details,
    this.serialnc,
    this.pricec,
    this.weightc,
    this.brandname,
    this.quntityc,
    this.imgurl,
    this.isonsale,
    this.ispopular,
  });
  CollectionReference db = FirebaseFirestore.instance.collection('products');

  Future<void> addproduct(ProductModel productModel) async {
    Map<String, dynamic> data = {
      'category': productModel.productNamec,
      'productNamec': productModel.category,
      'details': productModel.details,
      'serialnc': productModel.serialnc,
      'pricec': productModel.pricec,
      'weightc': productModel.weightc,
      'brandc': productModel.brandname,
      'quntityc': productModel.quntityc,
      'imgurl': productModel.imgurl,
      'isonsale': productModel.isonsale,
      'ispopular': productModel.ispopular,
    };
    await db.add(data);
  }

  Future<void> updateproduct(String id, ProductModel updateModel) async {
    Map<String, dynamic> data = {
      'category': updateModel.productNamec,
      'productNamec': updateModel.category,
      'details': updateModel.details,
      'serialnc': updateModel.serialnc,
      'pricec': updateModel.pricec,
      'weightc': updateModel.weightc,
      'brandc': updateModel.brandname,
      'quntityc': updateModel.quntityc,
      'imgurl': updateModel.imgurl,
      'isonsale': updateModel.isonsale,
      'ispopular': updateModel.ispopular,
    };
    await db.doc(id).update(data);
  }

  Future<void> delete(String id) async {
    await db.doc(id).delete();
  }
}
