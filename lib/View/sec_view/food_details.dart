import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';

import 'package:food_delivery_app/Models/product_model.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get.dart';

class FoodDetailsView extends StatelessWidget {
  final ProductModel productModel;
  const FoodDetailsView({
    required this.productModel,
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
              title:
                  buildCustomText(text: productModel.name, color: Colors.white),
              background: Image.network(
                productModel.image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    buildCustomText(text: "Name : ", size: 24),
                    buildCustomText(
                        text: productModel.name, size: 24, color: Colors.pink),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    buildCustomText(text: "Restaurant name : ", size: 24),
                    Flexible(
                      child: buildCustomText(
                          text: productModel.restName,
                          size: 24,
                          color: Colors.pink),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: buildCustomText(text: "Descreiption : ", size: 24),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: buildCustomText(
                    text: productModel.des,
                    size: 24,
                    max: 6,
                    color: Colors.pinkAccent),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    buildCustomText(text: "Price: ", size: 24),
                    buildCustomText(
                        text: productModel.price.toString() + " EGP",
                        size: 24,
                        color: Colors.pinkAccent),
                  ],
                ),
              ),
              GetBuilder<CartController>(
                init: Get.put(CartController(), permanent: true),
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () {
                        controller.insertToDatabase(
                            foodName: productModel.name,
                            price: productModel.price,
                            imageUrl: productModel.image,
                            quantity: 1);
                      },
                      enableFeedback: true,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.black12,
                                spreadRadius: 3)
                          ],
                          gradient: LinearGradient(
                              colors: [Colors.pinkAccent, Colors.amber],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Center(
                          child: buildCustomText(
                              text: "ADD TO CART", color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
