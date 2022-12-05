import 'dart:convert';

import 'package:delevery_app/controllers/cart_controller.dart';
import 'package:delevery_app/base/no_data_page.dart';
import 'package:delevery_app/routes/rout_helper.dart';
import 'package:delevery_app/utils/dimension.dart';
import 'package:delevery_app/widget/app_icon.dart';
import 'package:delevery_app/widget/big_text.dart';
import 'package:delevery_app/widget/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../models/cart_models.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //reversed => it's become a iterable object you can't go through it index by index
    //add .reversed + .toList() to reverse the list and converted to list again
    var historyList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = {};

    //to count how many time repeated
    for(int i=0; i<historyList.length; i++){
      if(cartItemsPerOrder.containsKey(historyList[i].time)){
        cartItemsPerOrder.update(historyList[i].time!, (value)=>++value);
      }else{
        cartItemsPerOrder.putIfAbsent(historyList[i].time!, ()=>1);
      }
    }// => {time-12:22 : 3}{13:23 : 2}

    List<int> cartItemPerOrderToList(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    } //convert map to list  and return item per order=> [3,1,3]

    List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }//return time when make an order

    List<int> itemsPerOrder = cartItemPerOrderToList();

    var listCount = 0;
    Widget timeWidget(index){
      var outputDate = DateTime.now().toString();
      if(index<historyList.length){
        DateTime parseDate= DateFormat("yyyy-MM-dd HH:mm:ss").parse(historyList[listCount].time!);
        //converted to String to pass it (.format=>takes String)
        var inputDate= DateTime.parse(parseDate.toString());
        //the format we want to display
        var outputFormat=DateFormat("MM/dd/yyyy hh:mm");
        //pass a String Date format
        outputDate=outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      body: Column(
        children: [
          //header // appBar
          Container(
            padding: EdgeInsets.only(top: Dimention.heigt15*3),
            decoration: BoxDecoration(color: AppColors.mainColor),
            width: double.maxFinite,
            height: Dimention.heigt20*5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                AppIconWidget(icon: Icons.shopping_cart_outlined, iconColor: AppColors.mainColor,)
              ],
            ),
          ),
          //body
          GetBuilder<CartController>(builder: (cartController){
            return cartController.getCartHistoryList().isNotEmpty?Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimention.heigt20,
                    left: Dimention.width20,
                    right: Dimention.width20
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    children: [
                      for(int i=0; i<itemsPerOrder.length; i++)
                        Container(
                          height: Dimention.heigt30*4,
                          margin: EdgeInsets.only(bottom: Dimention.heigt20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Immediately invoking an anonymous function
                              timeWidget(listCount),
                              SizedBox(height: Dimention.heigt10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i], (index) {
                                      //4:35 Inner loop
                                      if(listCount<historyList.length){
                                        //check to avoid over flow
                                        listCount++;
                                      }
                                      return index<=2?Container(
                                        margin: EdgeInsets.only(right: Dimention.heigt10/2),
                                        width: Dimention.width20*4,
                                        height: Dimention.heigt20*4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimention.heigt15/2),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL+AppConstants.UPLOADE_URI+historyList[listCount-1].img!
                                              ),
                                            )
                                        ),
                                      ):Container();
                                    }
                                    ),
                                  ),
                                  Container(
                                    height: Dimention.heigt20*4,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text: "Total", color: AppColors.titleColor,),
                                        BigText(text: "${itemsPerOrder[i]} Items", color: AppColors.titleColor,),
                                        GestureDetector(
                                          onTap:(){
                                            var orderTime = cartOrderTimeToList();
                                            Map<int, CartModel> moreOrder = {};
                                            for(int j=0; j<historyList.length; j++){
                                              if(orderTime[i]==historyList[j].time){
                                                moreOrder.putIfAbsent(historyList[j].id!, () =>
                                                    CartModel.fromJson(jsonDecode(jsonEncode(historyList[j])))
                                                  //parse string and return Json Object<=from object to Json String<=List<CartModel>
                                                );
                                              }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());
                                            }
                                            //print("Order Time   : "+orderTime[i]);
                                            //print("History List : ${historyList[i].time}");
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: Dimention.heigt10/2, horizontal: Dimention.width10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimention.heigt15/3),
                                              border: Border.all(width: 1, color: AppColors.mainColor),
                                            ),
                                            child: SmallText(text: "One More", color: AppColors.mainColor,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ):
            SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
                child: const NoDataPage(
              text: "You didn't bug anything so far !",
              imgPate: "assets/image/empty_box.png",
            ));
          })
        ],
      ),
    );
  }
}
