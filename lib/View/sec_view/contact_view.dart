import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/home_controller.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactView extends StatelessWidget {
  var reportController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildCustomText(text: "Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCustomText(text: "Write your message : ", size: 24),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20)),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: reportController,
                    style: GoogleFonts.nunito(
                        fontSize: 22, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(border: InputBorder.none),
                    maxLines: null,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GetBuilder<HomeController>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildCustomText(text: "Send", size: 24),
                      SizedBox(
                        width: 10,
                      ),
                      buildNextButton(onTap: () {
                        controller.sendReport(message: reportController.text);
                      })
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
