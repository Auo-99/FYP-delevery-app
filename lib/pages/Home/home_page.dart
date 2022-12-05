import 'package:delevery_app/pages/auth/sign_up_page.dart';
import 'package:delevery_app/pages/cart/cart_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../account/account_page.dart';
import '../auth/sign_in_page.dart';
import 'home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;
  var pages = [
    HomePageBody(),
    const Center(child: Text("History Page"),),
    CartHistory(),
    AccountPage(),
  ];

  onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.blueGrey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          onTap: onTapNav,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.archive), label: "Archive"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Me"),
          ]
      ),
    );
  }
}
