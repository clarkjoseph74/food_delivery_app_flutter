import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Models/cart_el_model.dart';
import 'package:food_delivery_app/Models/order_model.dart';
import 'package:food_delivery_app/Models/product_model.dart';
import 'package:food_delivery_app/Models/report.dart';
import 'package:food_delivery_app/Models/user_model.dart';
import 'package:food_delivery_app/View/primary_view/explore.dart';
import 'package:food_delivery_app/View/primary_view/profile.dart';
import 'package:food_delivery_app/View/primary_view/restaurant.dart';
import 'package:food_delivery_app/View/primary_view/search.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lottie/lottie.dart';

class HomeController extends GetxController {
  int currentScreenIndex = 0;
  List<Widget> screens = [
    ExploreScreen(),
    RestScreen(),
    SearchScreen(),
    ProfileScreen()
  ];

  @override
  void onInit() {
    getCurrentUser();
    getPopular();
    getProducts();
    super.onInit();
  }

  void changeScreenIndex(int index) {
    currentScreenIndex = index;
    update();
  }

  var popularCollection = FirebaseFirestore.instance.collection('popular');
  var usersCollection = FirebaseFirestore.instance.collection('users');
  List<ProductModel> popular = [];
  getPopular() {
    popularCollection.get().then((value) {
      value.docs.forEach((element) {
        popular.add(ProductModel.fromMap(element.data()));
      });
      update();
      print(value.docs.length);
    }).catchError((err) {
      print(err);
    });
  }

  var productsCollection = FirebaseFirestore.instance.collection('products');
  List<ProductModel> products = [];
  getProducts() {
    productsCollection.get().then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromMap(element.data()));
      });
      update();
      print(value.docs.length);
    }).catchError((err) {
      print(err);
    });
  }

  UserModel? currentUser;
  getCurrentUser({uid}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    String currentUserId = user!.uid;
    // var cuid = await SharedPref.getStringFromSHaredPref(key: "logined");
    usersCollection.doc(currentUserId).get().then((value) {
      currentUser = UserModel.fromMap(value.data()!);
      print(value.data()!['name']);
      update();
    }).catchError((err) {
      print("Err : " + err.toString());
    });
  }

  List<ProductModel> searchedProducts = [];
  getSearchedProduct({required String text}) {
    searchedProducts = products;
    var res = text.toLowerCase();
    searchedProducts = products
        .where((element) => element.name.toLowerCase().contains(res))
        .toList();
    update();
    print(searchedProducts.length);
  }

  ImagePicker _picker = ImagePicker();
  var pickedImage;
  var profilePic;
  var stroage = firebase_storage.FirebaseStorage.instance;
  pickImageFromGallery() async {
    pickedImage =
        await _picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        profilePic = File(value.path);
        uploadPictureToStorage(file: profilePic);
      } else {
        Get.snackbar("No Image Selected", "Try Again",
            snackPosition: SnackPosition.BOTTOM);
      }
      update();
    }).catchError((err) {
      print(err);
    });
  }

  var load = false;
  String profilePicUrl = '';
  uploadPictureToStorage({required File file}) {
    load = true;
    stroage
        .ref()
        .child("images/users/${Uri.file(file.path).pathSegments.last}")
        .putFile(file)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        profilePicUrl = value;
        upadteProfilePic(profile: profilePicUrl);
        update();
      });
    }).catchError((err) {
      print(err);
    });
  }

  upadteProfilePic({required String profile}) {
    usersCollection
        .doc(currentUser!.uid)
        .set({'image': profile}, SetOptions(merge: true)).then((value) {
      load = false;
      getCurrentUser();
      update();
    }).catchError((err) {
      Get.snackbar("Error", "Update Error",
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  sendOrder({required OrderModel orderModel}) {
    FirebaseFirestore.instance.collection('orders').add(orderModel.toMap());
    Get.defaultDialog(
        titlePadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        title: "Order Done",
        content: Column(
          children: [
            Lottie.asset('assets/images/done.json'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: buildCustomText(
                  text:
                      "The order will be deliver from 30 to 50 min. Thank you",
                  max: 3),
            )
          ],
        ));
  }

  sendReport({required message}) {
    Report report = Report(
        name: currentUser!.name, email: currentUser!.email, message: message);
    FirebaseFirestore.instance.collection('reports').add(report.toMap());
    Get.defaultDialog(
        titlePadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        title: "Report Send",
        content: Column(
          children: [
            Lottie.asset('assets/images/done.json'),
          ],
        ));
  }
}
