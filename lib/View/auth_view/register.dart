import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/Controllers/auth_controller.dart';
import 'package:food_delivery_app/view/widgets/common_widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/wavee.svg',
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.amber,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCustomText(text: "Register", size: 50),
                        buildCustomText(
                            text: "Connect to get food fast",
                            color: Colors.blueGrey),
                        buildCustomTextFormField(
                            hintText: "E-mail",
                            controller: emailController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Cant be Empty";
                              } else {
                                return null;
                              }
                            }),
                        buildCustomTextFormField(
                            hintText: "Name",
                            controller: nameController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Cant be Empty";
                              } else {
                                return null;
                              }
                            }),
                        buildCustomTextFormField(
                            hintText: "Address",
                            controller: addressController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Cant be Empty";
                              } else {
                                return null;
                              }
                            }),
                        GetBuilder<AUthController>(
                          builder: (controller) {
                            return buildCustomTextFormField(
                                hintText: "Password",
                                controller: passController,
                                obsc: controller.isShown,
                                widget: IconButton(
                                    onPressed: () {
                                      controller.changeIsShownState();
                                    },
                                    icon: Icon(controller.isShown
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye)),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Cant be Empty";
                                  } else {
                                    return null;
                                  }
                                });
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GetBuilder<AUthController>(
                          builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildCustomText(text: "Register", size: 25),
                                SizedBox(
                                  width: 20,
                                ),
                                buildNextButton(onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.signUp(
                                        name: nameController.text,
                                        address: addressController.text,
                                        email: emailController.text,
                                        password: passController.text);
                                    Get.back();
                                  }
                                }),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildCustomText(text: "Already have an account ? "),
                            InkWell(
                              child: buildCustomText(
                                  text: "Login ", color: Colors.blue),
                              onTap: () {
                                Get.back();
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/wave.svg',
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
