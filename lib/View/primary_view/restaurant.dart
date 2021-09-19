import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/rest_controller.dart';
import 'package:food_delivery_app/View/sec_view/restaurant_details.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestController>(
      builder: (controller) {
        return Column(
          children: [
            SizedBox(height: 50),
            buildCustomText(
                text: "Restaurants", color: Colors.pinkAccent, size: 27),
            Expanded(
              child: Container(
                //color: Colors.indigo[300],
                child: controller.restaurants.length == 0
                    ? Center(
                        child: Lottie.asset(
                        'assets/images/loading.json',
                      ))
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(10),
                        itemCount: controller.restaurants.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: InkWell(
                              onTap: () {
                                controller.getRestProducts(
                                    rest: controller.restaurants[index].name);
                                Get.to(() => RestDetailsVies(
                                    restaurantModel:
                                        controller.restaurants[index]));
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        controller.restaurants[index].image),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildCustomText(
                                          text: controller
                                              .restaurants[index].name,
                                          size: 25),
                                      buildCustomText(
                                          text: controller
                                              .restaurants[index].location,
                                          size: 20,
                                          color: Colors.blueGrey),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
