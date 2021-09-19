import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/Controllers/auth_controller.dart';

import 'package:food_delivery_app/view/auth_view/register.dart';
import 'package:food_delivery_app/view/widgets/common_widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  var emailController = TextEditingController();
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
          physics: NeverScrollableScrollPhysics(),
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
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCustomText(text: "Login", size: 50),
                        buildCustomText(
                            text: "Login to get food fast",
                            color: Colors.blueGrey),
                        const SizedBox(
                          height: 35,
                        ),
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
                        const SizedBox(
                          height: 15,
                        ),
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
                          height: 50,
                        ),
                        GetBuilder<AUthController>(
                          //init: AUthController(),
                          builder: (controller) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildCustomText(text: "Login", size: 25),
                                SizedBox(
                                  width: 20,
                                ),
                                buildNextButton(onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.login(
                                        email: emailController.text,
                                        password: passController.text);
                                  }
                                }),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildCustomText(text: "Dont have an account ? "),
                            InkWell(
                              child: buildCustomText(
                                  text: "SignUp ", color: Colors.blue),
                              onTap: () {
                                Get.to(() => RegisterView());
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/images/wave.svg',
                alignment: Alignment.bottomCenter,
                height: 120,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
