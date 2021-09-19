import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/home_controller.dart';
import 'package:food_delivery_app/Controllers/rest_controller.dart';

import 'package:food_delivery_app/Models/product_model.dart';
import 'package:food_delivery_app/Models/rest_model.dart';
import 'package:food_delivery_app/View/sec_view/food_details.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';

class RestDetailsVies extends StatelessWidget {
  final RestaurantModel restaurantModel;
  const RestDetailsVies({
    required this.restaurantModel,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            excludeHeaderSemantics: false,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              centerTitle: true,
              title: buildCustomText(
                  text: restaurantModel.name, color: Colors.black),
              background: Image.network(
                restaurantModel.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          GetBuilder<RestController>(
            init: Get.put(RestController()),
            builder: (controller) {
              return SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      return controller.restProducts.length == 0
                          ? CircularProgressIndicator()
                          : Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => FoodDetailsView(
                                      productModel:
                                          controller.restProducts[index]));
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: [
                                          Container(
                                            alignment: Alignment.topCenter,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    controller
                                                        .restProducts[index]
                                                        .image,
                                                  ),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3, vertical: 2),
                                              child: buildCustomText(
                                                  text: controller
                                                      .restProducts[index]
                                                      .restName),
                                              decoration: BoxDecoration(
                                                  color: Colors.pinkAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      buildCustomText(
                                          text: controller
                                              .restProducts[index].name),
                                      buildCustomText(
                                          text: controller
                                                  .restProducts[index].price
                                                  .toString() +
                                              " EGP",
                                          color: primaryColor),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                    childCount: controller.restProducts.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ));
            },
          )
        ],
      ),
    );
  }
}
