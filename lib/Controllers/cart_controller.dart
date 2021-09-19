import 'package:food_delivery_app/Models/cart_el_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:sqflite/sqflite.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    createDatabase();
    getTotalPrice();
    super.onInit();
  }

  Database? database;
  Future<void> createDatabase() async {
    database = await openDatabase('cartdb.db', version: 1,
        onCreate: (Database db, int version) async {
      print("Database Created....");
      update();

      await db
          .execute(
              'CREATE TABLE cart (id INTEGER PRIMARY KEY,name TEXT,price INTEGER, image TEXT,quantity INTEGER)')
          .then((value) => print("DB Table Created ..."))
          .catchError((err) {
        print("Error When Create DB Table");
      });
    }, onOpen: (Database db) {
      print("Database Opened....");
      getAllFromDatabase(db: db);
      update();
    });
    update();
  }

  insertToDatabase({
    required String foodName,
    required int price,
    required String imageUrl,
    required int quantity,
  }) async {
    if (cartElements.length == 0) {
      addElementToDatabase(
          foodName: foodName,
          price: price,
          imageUrl: imageUrl,
          quantity: quantity);
      Get.snackbar("Success", "Add To Cart");
      update();
    } else {
      for (var i = 0; i < cartElements.length; i++) {
        if (cartElements[i].name == foodName) {
          return;
        }
      }
      addElementToDatabase(
          foodName: foodName,
          price: price,
          imageUrl: imageUrl,
          quantity: quantity);
      Get.snackbar("Success", "Add To Cart");
      update();
    }
  }

  addElementToDatabase({
    required String foodName,
    required int price,
    required String imageUrl,
    required int quantity,
  }) async {
    await database!.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO cart(name,price,image,quantity) VALUES("$foodName",$price,"$imageUrl",$quantity)')
          .then((value) {
        print("$value Inserted ");
        cartElements = [];
        getAllFromDatabase(db: database);
        update();
      }).catchError((err) {});
      return Future.delayed(Duration(microseconds: 1));
    });

    update();
  }

  List<CartElement> cartElements = [];
  getAllFromDatabase({required db}) async {
    List<Map> list = await db!.rawQuery('SELECT * FROM cart');
    list.forEach((element) {
      cartElements.add(CartElement.fromMap(element));
      update();
    });
    print("Length : " + cartElements.length.toString());
    totalPrice = 0;
    getTotalPrice();
    update();
  }

  deleteElementFromdb({required String name}) async {
    cartElements = [];
    var count =
        await database!.rawDelete('DELETE FROM cart WHERE name = ?', ['$name']);
    print(count);
    update();
    getAllFromDatabase(db: database);
  }

  onPlusTap({required int index}) {
    cartElements[index].quantity++;
    totalPrice = 0;
    getTotalPrice();
    update();
  }

  onMinusTap({required int index}) {
    if (cartElements[index].quantity > 1) {
      cartElements[index].quantity--;
      totalPrice = 0;
      getTotalPrice();
      update();
    }
  }

  var totalPrice = 0;
  getTotalPrice() {
    for (int i = 0; i < cartElements.length; i++) {
      totalPrice += (cartElements[i].price * cartElements[i].quantity);
      print(totalPrice);
    }
    update();
  }
}
