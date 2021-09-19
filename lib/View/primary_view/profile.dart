import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/auth_controller.dart';

import 'package:food_delivery_app/Controllers/home_controller.dart';
import 'package:food_delivery_app/View/sec_view/contact_view.dart';
import 'package:food_delivery_app/View/sec_view/edit_profile.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        controller.currentUser!.image,
                      ),
                      radius: 60,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCustomText(
                        text: controller.currentUser!.name, size: 26),
                    buildCustomText(
                        text: controller.currentUser!.email,
                        size: 20,
                        color: Colors.blueGrey),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Colors.amber,
                  //   ],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    //   color: Colors.amber[200],
                    border: Border.all(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                  onTap: () {
                    Get.to(EditProfile());
                  },
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: buildCustomText(text: "Edit Profile", size: 20),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    //   color: Colors.amber[200],
                    border: Border.all(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                  onTap: () {
                    Get.to((ContactView()));
                  },
                  leading: Icon(
                    Icons.support_agent,
                    color: Colors.black,
                  ),
                  title: buildCustomText(text: "Contact Us", size: 20),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GetBuilder<AUthController>(
                builder: (controller) => Container(
                  decoration: BoxDecoration(
                      //   color: Colors.amber[200],
                      border: Border.all(color: primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(30)),
                  child: ListTile(
                    onTap: () {
                      controller.signOut();
                    },
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    title: buildCustomText(text: "Logout", size: 20),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
