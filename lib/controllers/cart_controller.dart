import 'package:delevery_app/data/repository/cart_repo.dart';
import 'package:delevery_app/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/cart_models.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items={};
  Map<int, CartModel> get items => _items;

  //only for storage and shared preferences
  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity){

    if(_items.containsKey(product.id)){
      var totalQuantity = 0;
      _items.update(product.id!, (value) {

        totalQuantity = value.quantity!+quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity!+quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if(totalQuantity <= 0){
        _items.remove(product.id);
      }
    }else{
      if(quantity > 0){
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            //pass value from productModel to CartModel
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );});
      }else{
        Get.snackbar(
                "Item Count!",
                "At least one item must be added !",
                backgroundColor: AppColors.mainColor,
                colorText: Colors.white,
              );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool isExist(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }else{
      return false;
    }
  }

  int getQuantity(ProductModel product){
    //get quantity that saved in local map _items{}
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalItems = 0;
    _items.forEach((key, value) {
      totalItems += value.quantity!;
    });
    return totalItems;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get getAmount{
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  // getCartData and setCart for storage and sharedPreferences only
  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items;
    //print("length of cart items ${storageItems.length}");

    for(int i=0;i<storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToCartHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items={};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems){
    //when press in One More in cart history page
    //we will pass the items in that order to cart page
    //pass moreOreder map to _items map
    _items = {};//make sure the map is empty
    _items = setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }

}

//1-> create repo
//2-> create controller
//3-> load controller and repo in dependencies
