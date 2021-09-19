import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/home_controller.dart';
import 'package:food_delivery_app/Models/user_model.dart';
import 'package:food_delivery_app/View/auth_view/login_view.dart';
import 'package:food_delivery_app/View/primary_view/homepage.dart';
import 'package:food_delivery_app/helper/shared_pref.dart';
import 'package:get/get.dart';

class AUthController extends GetxController {
  bool isShown = true;

  var usersCollection = FirebaseFirestore.instance.collection('users');

  changeIsShownState() {
    isShown = !isShown;
    update();
  }

  login({
    required String email,
    required String password,
  }) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      SharedPref.saveStringInSHaredPref(key: "logined", value: value.user!.uid);
      Get.to(() => HomePage());
      HomeController().getCurrentUser();
      Get.snackbar("Login Success", "Order Food Now",
          backgroundColor: Colors.green, snackPosition: SnackPosition.BOTTOM);
    }).catchError((err) {
      Get.snackbar("Login Failed", "$err",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    });
    update();
  }

  signUp({
    required String name,
    required String address,
    required String email,
    required String password,
  }) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      var uid = value.user!.uid;
      saveUser(uid: uid, email: email, name: name, address: address);
      Get.snackbar("Register Done", "Login Now",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3));
    }).catchError((err) {
      Get.snackbar("Register Failed", "$err",
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3));
    });

    update();
  }

  saveUser({
    required String uid,
    required String email,
    required String name,
    required String address,
  }) {
    UserModel userModel = UserModel(
        uid: uid,
        name: name,
        email: email,
        address: address,
        image:
            "https://image.freepik.com/free-photo/medium-shot-happy-man-smiling_23-2148221808.jpg");

    usersCollection
        .doc(uid)
        .set(userModel.toMap())
        .then((value) => print("done"))
        .catchError((err) {
      print(err);
    });
    update();
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    SharedPref.shaerdClear();
    Get.off(LoginView());
  }
}
