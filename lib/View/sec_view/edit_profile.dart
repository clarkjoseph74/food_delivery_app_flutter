import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/Controllers/home_controller.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  final nameController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildCustomText(text: "Edit Profile"),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        nameController.text = controller.currentUser!.name;
        nameController.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.currentUser!.name.length));
        addressController.text = controller.currentUser!.address;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    controller.load == true
                        ? CircularProgressIndicator()
                        : CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              controller.profilePic == null
                                  ? controller.currentUser!.image
                                  : controller.profilePicUrl,
                            ),
                            radius: 50,
                          ),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 18,
                      child: InkWell(
                        onTap: () {
                          controller.pickImageFromGallery();
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                buildCustomTextFormField(
                    hintText: "Name",
                    controller: nameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Cant be Empty';
                      } else {
                        return null;
                      }
                    }),
                SizedBox(
                  height: 15,
                ),
                buildCustomTextFormField(
                    hintText: "Address",
                    controller: addressController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Cant be Empty';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.amber,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: buildCustomText(text: "SAVE CHANGES"),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
