import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:soapy_app/pages/Products/product.dart';
import 'package:soapy_app/pages/bookinghistory.dart';
import 'package:soapy_app/pages/home.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _currentIndex = 0; // Set initial index for "Home"

  // List of pages for the tab bar
  final List<Widget> _pages = [
    Home(), // Replace with your ProductPage widget
   
    ProductDetails(),
    Bookinghistory(), // Replace with your BookingHistoryPage widget
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 76, 189, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: MotionTabBar(
          initialSelectedTab: "Home", // Set initial selected tab
          useSafeArea: true,
          labels: ["Home", "Products", "Booking History"],
          icons: [Icons.home, Icons.shopping_cart, Icons.history],
          tabSize: 52,
          tabBarHeight: 55,
          tabBarColor: Colors.transparent,
          textStyle: const TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          tabIconColor: Colors.black,
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: Colors.white,
          tabIconSelectedColor: Colors.black,
          onTabItemSelected: (int value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
      ),
    );
  }
}
