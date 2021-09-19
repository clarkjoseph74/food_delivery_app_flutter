import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_delivery_app/Controllers/home_controller.dart';

import 'package:food_delivery_app/Models/cart_el_model.dart';
import 'package:food_delivery_app/Models/order_model.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class ShippingView extends StatelessWidget {
  List<CartElement> foodOrders;
  int totalPrice;
  ShippingView({
    required this.foodOrders,
    required this.totalPrice,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: buildCustomText(text: "Apply Order"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: foodOrders.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: 120,
                                    width: 130,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.network(
                                      foodOrders[index].image,
                                      fit: BoxFit.cover,
                                    )),
                                buildCustomText(text: foodOrders[index].name),
                                buildCustomText(
                                    text: "Quantity : " +
                                        foodOrders[index].quantity.toString(),
                                    color: primaryColor),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  buildCustomText(
                      text: "Name : ", color: primaryColor, size: 22),
                  buildCustomText(text: controller.currentUser!.name, size: 20),
                  const SizedBox(
                    height: 10,
                  ),
                  buildCustomText(
                      text: "Shipping Address : ",
                      color: primaryColor,
                      size: 22),
                  buildCustomText(
                      text: controller.currentUser!.address, size: 20),
                  const SizedBox(
                    height: 10,
                  ),
                  buildCustomText(
                      text: "Total price : ", color: primaryColor, size: 22),
                  buildCustomText(
                      text: totalPrice.toString() + " EGP", size: 20),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildCustomText(text: "Apply ", size: 24),
                      buildNextButton(onTap: () {
                        controller.sendOrder(
                            orderModel: OrderModel(
                                foodOrder: foodOrders,
                                name: controller.currentUser!.name,
                                location: controller.currentUser!.address,
                                totalPrice: totalPrice.toString()));
                      }),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
