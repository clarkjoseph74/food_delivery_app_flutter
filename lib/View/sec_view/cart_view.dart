import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/View/sec_view/shipping.dart';

import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartView extends StatelessWidget {
  var disKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.put(CartController(), permanent: true),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: buildCustomText(text: "Cart", size: 20),
          ),
          body: controller.cartElements.length == 0
              ? Container(
                  child: Center(
                    child: Lottie.asset('assets/images/empty_cart.json'),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 5),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.cartElements.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Slidable(
                                      actionPane: SlidableBehindActionPane(),
                                      secondaryActions: [
                                        IconSlideAction(
                                          caption: 'Delete',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () {
                                            controller.deleteElementFromdb(
                                                name: controller
                                                    .cartElements[index].name);
                                          },
                                        ),
                                      ],
                                      actionExtentRatio: 1.5 / 5,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                height: 120,
                                                width: 120,
                                                child: Image.network(
                                                  controller.cartElements[index]
                                                      .image,
                                                  fit: BoxFit.cover,
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  buildCustomText(
                                                      text: controller
                                                          .cartElements[index]
                                                          .name),
                                                  buildCustomText(
                                                      text: controller
                                                              .cartElements[
                                                                  index]
                                                              .price
                                                              .toString() +
                                                          " EGP",
                                                      color: Colors.amber),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Colors.pinkAccent,
                                                        radius: 13,
                                                        child: Center(
                                                          child: IconButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            icon: Text(
                                                              '+',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .onPlusTap(
                                                                      index:
                                                                          index);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: buildCustomText(
                                                            text: controller
                                                                .cartElements[
                                                                    index]
                                                                .quantity
                                                                .toString()),
                                                      ),
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Colors.pinkAccent,
                                                        radius: 13,
                                                        child: Center(
                                                          child: IconButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0),
                                                            icon: Text(
                                                              '-',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .onMinusTap(
                                                                      index:
                                                                          index);
                                                            },
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 60,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    buildCustomText(
                                        text: "total price : ", size: 22),
                                    buildCustomText(
                                        text: controller.totalPrice.toString() +
                                            " EGP",
                                        size: 20,
                                        color: primaryColor)
                                  ],
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                buildCustomText(text: "Apply order ", size: 22),
                                buildNextButton(onTap: () {
                                  Get.to(ShippingView(
                                    foodOrders: controller.cartElements,
                                    totalPrice: controller.totalPrice,
                                  ));
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
