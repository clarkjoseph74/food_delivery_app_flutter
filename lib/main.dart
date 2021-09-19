import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:food_delivery_app/View/primary_view/homepage.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/binding/app_binding.dart';
import 'package:food_delivery_app/helper/shared_pref.dart';
import 'package:food_delivery_app/view/auth_view/login_view.dart';
import 'package:food_delivery_app/view/widgets/common_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPref.initialize();
  CURRENTUSERID = await SharedPref.getStringFromSHaredPref(key: "logined");
  runApp(MyApp(
    currentUid: CURRENTUSERID,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String? currentUid;
  MyApp({
    required this.currentUid,
  });
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
            backwardsCompatibility: false,
            color: Colors.amber,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: primaryColor,
                systemNavigationBarColor: primaryColor,
                statusBarBrightness: Brightness.dark)),
        primarySwatch: Colors.amber,
      ),
      home: currentUid == null ? LoginView() : HomePage(),
    );
  }
}
