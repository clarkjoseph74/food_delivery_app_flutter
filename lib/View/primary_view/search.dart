import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/home_controller.dart';
import 'package:food_delivery_app/View/sec_view/food_details.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GetBuilder<HomeController>(
          //init: Get.put(HomeController(), permanent: true),
          builder: (controller) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                          onChanged: (val) {
                            print(val);
                            controller.getSearchedProduct(text: val.toString());
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: GoogleFonts.nunito(
                                color: Colors.grey,
                                fontSize: 22,
                              )),
                        ),
                      ),
                    ),
                    controller.searchedProducts.length == 0
                        ? Lottie.asset(
                            'assets/images/searching.json',
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.searchedProducts.length,
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
                                          controller.searchedProducts[index]));
                                },
                                child: Hero(
                                  tag: "product",
                                  child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                              alignment: Alignment.topCenter,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                      controller
                                                          .searchedProducts[
                                                              index]
                                                          .image,
                                                    ),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3, vertical: 2),
                                                child: buildCustomText(
                                                    text: controller
                                                        .searchedProducts[index]
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
                                                .searchedProducts[index].name),
                                        buildCustomText(
                                            text: controller
                                                    .searchedProducts[index]
                                                    .price
                                                    .toString() +
                                                " EGP",
                                            color: primaryColor),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                  ],
                ),
              )),
    );
  }
}
