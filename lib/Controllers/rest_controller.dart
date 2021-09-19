import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/Models/product_model.dart';
import 'package:food_delivery_app/Models/rest_model.dart';
import 'package:get/get.dart';

class RestController extends GetxController {
  @override
  void onInit() {
    getRestaurants();
    super.onInit();
  }

  var restCollection = FirebaseFirestore.instance.collection('restaurants');
  List<RestaurantModel> restaurants = [];
  getRestaurants() {
    restCollection.get().then((value) {
      value.docs.forEach((element) {
        restaurants.add(RestaurantModel.fromMap(element.data()));
      });
      update();
      print(value.docs.length);
    }).catchError((err) {
      print(err);
    });
  }

  List<ProductModel> restProducts = [];
  getRestProducts({required String rest}) {
    restProducts = [];
    FirebaseFirestore.instance
        .collection('products')
        .where("restName", isEqualTo: rest)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        restProducts.add(ProductModel.fromMap(element.data()));
      });
      update();
      print('rest length :' + " ${restProducts.length}");
    }).catchError((err) {});
  }
}
