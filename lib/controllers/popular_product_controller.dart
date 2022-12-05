import 'package:delevery_app/controllers/cart_controller.dart';
import 'package:delevery_app/data/repository/popular_product_repo.dart';
import 'package:delevery_app/models/cart_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/products_model.dart';
import '../utils/colors.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool isIncrement = false;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  late CartController _cart;
  //CartController get cart => _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;

      update();
    } else {print("Could not get popular product");}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      //print("Increment the quantity is : $_quantity" );
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    //check when setQuantity is triggered inCartItems -\+ 1 is true or not
    if ((quantity+_inCartItems) < 0) {
      Get.snackbar(
        "obs!",
        "You can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      //solving error : when reduce less than 0 quantity=0 inCartItem = 2~
      //it will return 2-0 = 2
      //now will change the quantity to (-inCartItem) to be sure the answer is = 0
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((quantity+_inCartItems) > 20) {
      Get.snackbar(
        "obs!",
        "You can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      //return what ever it's send -1 or +1
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.isExist(product);
    //print("Exist or Not : " + exist.toString());
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    //print("the quantity in the cart is "+_inCartItems.toString());
  }

  void addItem(ProductModel product){
    //if(_quantity>0){
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        //print("The Id is: ${value.id} Quantity is : ${value.quantity}");
      });
      update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }
}


