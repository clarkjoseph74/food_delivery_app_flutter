import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/Controllers/home_controller.dart';
import 'package:food_delivery_app/View/sec_view/cart_view.dart';
import 'package:food_delivery_app/View/sec_view/food_details.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.currentUser == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                  child: Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 45,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildCustomText(
                                      text: "Shipping address",
                                      color: primaryColor),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 22,
                                      ),
                                      buildCustomText(
                                          text: controller.currentUser!.address,
                                          fontWeight: FontWeight.normal),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  GetBuilder<CartController>(
                                    init: Get.put(CartController(),
                                        permanent: true),
                                    builder: (controller) {
                                      return IconButton(
                                          onPressed: () {
                                            Get.to(() => CartView());
                                          },
                                          icon: Badge(
                                            badgeContent: buildCustomText(
                                                text: controller
                                                    .cartElements.length
                                                    .toString(),
                                                color: Colors.white),
                                            position:
                                                BadgePosition.topEnd(top: -15),
                                            child: Icon(
                                              Icons.shopping_cart_sharp,
                                              color: Colors.blue,
                                              size: 30,
                                            ),
                                          ));
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        controller.currentUser!.image),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildCustomText(text: "Popular ", size: 25),
                          SizedBox(
                            height: 10,
                          ),
                          controller.popular.length == 0
                              ? CircularProgressIndicator()
                              : CarouselSlider.builder(
                                  itemCount: controller.popular.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    controller
                                                        .popular[index].image,
                                                  ),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.primaries[index]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.pinkAccent,
                                            ),
                                            padding: EdgeInsets.all(5),
                                            child: buildCustomText(
                                                text: controller
                                                    .popular[index].name,
                                                size: 15),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                  options: CarouselOptions(
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 6),
                                      aspectRatio: 3 / 1.7,
                                      enlargeCenterPage: true,
                                      viewportFraction: 0.95)),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildCustomText(text: "Get Food ", size: 25),
                              buildCustomText(
                                  text: "See More ", color: Colors.pinkAccent),
                            ],
                          ),
                          controller.products.length == 0
                              ? CircularProgressIndicator()
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.products.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2 / 2.7,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => FoodDetailsView(
                                            productModel:
                                                controller.products[index]));
                                      },
                                      child: Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          controller
                                                              .products[index]
                                                              .image,
                                                        ),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3,
                                                            vertical: 2),
                                                    child: buildCustomText(
                                                        text: controller
                                                            .products[index]
                                                            .restName),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.pinkAccent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            buildCustomText(
                                                text: controller
                                                    .products[index].name),
                                            buildCustomText(
                                                text: controller
                                                        .products[index].price
                                                        .toString() +
                                                    " EGP",
                                                color: primaryColor),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
