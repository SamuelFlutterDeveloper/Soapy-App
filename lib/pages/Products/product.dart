// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:soapy_app/pages/Location/location.dart';
// import 'package:soapy_app/pages/Products/viewcart_prodects.dart';
// import 'package:soapy_app/pages/customs/colors.dart';
// import 'package:soapy_app/pages/profile.dart';

// class ProductDetails extends StatefulWidget {
//   @override
//   _ProductDetailsState createState() => _ProductDetailsState();
// }

// class _ProductDetailsState extends State<ProductDetails> {
//   String address2 = '';
//   int myCurrentIndex = 0;
//   List<int> counts = List.generate(6, (index) => 0);
//   List<int> quantities =
//       List.generate(6, (index) => 0); // Track quantities for each item

//   void incrementQuantity(int index) {
//     setState(() {
//       quantities[index]++;
//     });
//   }

//   void decrementQuantity(int index) {
//     setState(() {
//       if (quantities[index] > 0) {
//         quantities[index]--;
//       }
//     });
//   }

//   final List<String> imagePaths = [
//     'assets/images/1.jpg',
//     'assets/images/2.png',
//     'assets/images/3.jpg',
//     'assets/images/4.jpg',
//     'assets/images/5.jpg',
//     'assets/images/6.jpg',
//   ];

//   // List to keep track of favorite status
//   List<bool> isFavorite = List.generate(6, (index) => false);

//   // List of flavours
//   final List<String> flavours = [
//     "Strawberry Flavour",
//     "Apple Flavour",
//     "Hair & Body Care",
//     "Dishwash\nLime Flavour",
//     "Floor Cleaner\n Apple Flavour",
//     "Floor Cleaner\nLavender Flavour"
//   ];

//   Future<void> _loadLocationData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     address2 = prefs.getString('address') ?? '';
//     print('address---------------------->$address2');
//   }

//   @override
//   void initState() {
//     _loadLocationData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final myitems = [
//       ClipRRect(
//         borderRadius: BorderRadius.circular(25),
//         child: Image.asset('assets/images/Dish-slider1.png',
//             width: MediaQuery.of(context).size.width * 0.9, fit: BoxFit.cover),
//       ),
//       ClipRRect(
//         borderRadius: BorderRadius.circular(25),
//         child: Image.asset('assets/images/Dish-slider2.png',
//             width: MediaQuery.of(context).size.width * 0.9, fit: BoxFit.cover),
//       ),
//     ];

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 250, 243, 243),
//       appBar: PreferredSize(
//         preferredSize:
//             Size.fromHeight(MediaQuery.of(context).size.height * 0.165),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadiusDirectional.only(
//               bottomStart: Radius.circular(25),
//               bottomEnd: Radius.circular(25),
//             ),
//             color: Mycolor.maincolor,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 25, right: 18, top: 45),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Location',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Location()));
//                         },
//                         child: Icon(Icons.location_on, color: Colors.white)),
//                     SizedBox(width: 5),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Location()));
//                         },
//                         child: Text(
//                           "$address2",
//                           //------------------ widget.location,
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 7,
//                     ),
//                     Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         color: const Color.fromARGB(255, 122, 119, 119)
//                             .withOpacity(0.2),
//                       ),
//                       child: Icon(
//                         Icons.notifications,
//                         color: Colors.white,
//                         size: 25,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         height: 40,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Search...',
//                             prefixIcon: Icon(
//                               Icons.search,
//                               color: Color.fromARGB(252, 81, 186, 247),
//                             ),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide.none,
//                             ),
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 20),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 15),
//                     Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ProfilePage()));
//                         },
//                         child: Icon(
//                           Icons.person,
//                           color: Color.fromARGB(251, 27, 171, 255),
//                           size: 25,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             CarouselSlider(
//                 options: CarouselOptions(
//                   autoPlay: true,
//                   height: 190,
//                   autoPlayInterval: const Duration(seconds: 5),
//                   viewportFraction: 1,
//                   enlargeCenterPage: true,
//                   aspectRatio: 200,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       myCurrentIndex = index;
//                     });
//                   },
//                 ),
//                 items: myitems),
//             SizedBox(height: 15),
//             AnimatedSmoothIndicator(
//               activeIndex: myCurrentIndex,
//               count: myitems.length,
//               effect: WormEffect(
//                 dotHeight: 8,
//                 dotWidth: 8,
//                 spacing: 5,
//                 dotColor: const Color.fromARGB(255, 172, 171, 171),
//                 activeDotColor: Colors.blue,
//                 paintStyle: PaintingStyle.fill,
//               ),
//             ),
//             SizedBox(height: 30),
//             // Image List Section
//             ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: imagePaths.length,
//               itemBuilder: (context, index) {
//                 String heading = index < 2 ? 'HAND SOAPY' : 'STARINDO';
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   child: Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: Container(
//                           height: 250,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.3),
//                                 spreadRadius: 6,
//                                 blurRadius: 15,
//                                 offset: Offset(0, 10),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(20),
//                                   child: Image.asset(
//                                     imagePaths[index],
//                                     fit: BoxFit.cover,
//                                     height: 160,
//                                     width: 100,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         heading,
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Text(
//                                         flavours[index],
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Text(
//                                         'Netto: 20 Litre',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Container(
//                                         height: 35,
//                                         width: 113,
//                                         decoration: BoxDecoration(
//                                           color: const Color.fromARGB(
//                                               255, 170, 21, 10),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             SizedBox(width: 10),
//                                             Text(
//                                               "320 IDR",
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 15,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             SizedBox(width: 7),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.only(top: 5),
//                                               child: Text(
//                                                 "500 IDR",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     decoration: TextDecoration
//                                                         .lineThrough,
//                                                     fontSize: 10),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.end,
//                                         children: [
//                                           quantities[index] == 0
//                                               ? GestureDetector(
//                                                   onTap: () {
//                                                     incrementQuantity(index);
//                                                   },
//                                                   child: Container(
//                                                     height: 30,
//                                                     width: 80,
//                                                     decoration: BoxDecoration(
//                                                       color: Mycolor.maincolor,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15),
//                                                     ),
//                                                     child: Center(
//                                                       child: Text(
//                                                         'Add',
//                                                         style: TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 15,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )
//                                               : Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     IconButton(
//                                                       icon: Icon(Icons.remove),
//                                                       onPressed: () =>
//                                                           decrementQuantity(
//                                                               index),
//                                                     ),
//                                                     Text(
//                                                       '${quantities[index]}',
//                                                       style: TextStyle(
//                                                           fontSize: 24),
//                                                     ),
//                                                     IconButton(
//                                                       icon: Icon(Icons.add),
//                                                       onPressed: () =>
//                                                           incrementQuantity(
//                                                               index),
//                                                     ),
//                                                   ],
//                                                 ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: quantities.any((qty) => qty > 0)
//           ? Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               height: 50,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ViewcartProducts(
//                                 quantities: [],
//                                 imagePaths: [],
//                                 flavours: [],
//                                 initialQuantities: [],
//                               )));
//                 },
//                 backgroundColor: const Color.fromARGB(255, 36, 197, 42),
//                 child: Center(
//                   child: Text(
//                     '${quantities.reduce((a, b) => a + b)} items added   View Cart>',
//                     style: TextStyle(fontSize: 17, color: Colors.white),
//                   ),
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             )
//           : null,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:soapy_app/pages/Location/location.dart';
import 'package:soapy_app/pages/Products/viewcart_prodects.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/profile.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String address2 = '';
  int myCurrentIndex = 0;
  List<int> counts = List.generate(6, (index) => 0);
  List<int> quantities =
      List.generate(6, (index) => 0); // Track quantities for each item

  void incrementQuantity(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (quantities[index] > 0) {
        quantities[index]--;
      }
    });
  }

  final List<String> imagePaths = [
    'assets/images/1.jpg',
    'assets/images/2.png',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
  ];

  // List to keep track of favorite status
  List<bool> isFavorite = List.generate(6, (index) => false);

  // List of flavours
  final List<String> flavours = [
    "Strawberry Flavour",
    "Apple Flavour",
    "Hair & Body Care",
    "Dishwash\nLime Flavour",
    "Floor Cleaner\n Apple Flavour",
    "Floor Cleaner\nLavender Flavour"
  ];

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address2 = prefs.getString('address') ?? '';
    print('address---------------------->$address2');
  }

  @override
  void initState() {
    _loadLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myitems = [
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/Dish-slider1.png',
            width: MediaQuery.of(context).size.width * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/Dish-slider2.png',
            width: MediaQuery.of(context).size.width * 0.9, fit: BoxFit.cover),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 243, 243),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.165),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(25),
              bottomEnd: Radius.circular(25),
            ),
            color: Mycolor.maincolor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 18, top: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Location()));
                        },
                        child: Icon(Icons.location_on, color: Colors.white)),
                    SizedBox(width: 5),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Location()));
                        },
                        child: Text(
                          "$address2",
                          //------------------ widget.location,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: const Color.fromARGB(255, 122, 119, 119)
                            .withOpacity(0.2),
                      ),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search...',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color.fromARGB(252, 81, 186, 247),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        child: Icon(
                          Icons.person,
                          color: Color.fromARGB(251, 27, 171, 255),
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  height: 190,
                  autoPlayInterval: const Duration(seconds: 5),
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  aspectRatio: 200,
                  onPageChanged: (index, reason) {
                    setState(() {
                      myCurrentIndex = index;
                    });
                  },
                ),
                items: myitems),
            SizedBox(height: 15),
            AnimatedSmoothIndicator(
              activeIndex: myCurrentIndex,
              count: myitems.length,
              effect: WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                spacing: 5,
                dotColor: const Color.fromARGB(255, 172, 171, 171),
                activeDotColor: Colors.blue,
                paintStyle: PaintingStyle.fill,
              ),
            ),
            SizedBox(height: 30),
            // Image List Section
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: imagePaths.length,
              itemBuilder: (context, index) {
                String heading = index < 2 ? 'HAND SOAPY' : 'STARINDO';
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 6,
                                blurRadius: 15,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    imagePaths[index],
                                    fit: BoxFit.cover,
                                    height: 160,
                                    width: 100,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        heading,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        flavours[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Netto: 5 Litre',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 35,
                                        width: 113,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 170, 21, 10),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 10),
                                            Text(
                                              "320 INR",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 7),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Text(
                                                "500 INR",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          quantities[index] == 0
                                              ? GestureDetector(
                                                  onTap: () {
                                                    incrementQuantity(index);
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: Mycolor.maincolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Add',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.remove),
                                                      onPressed: () =>
                                                          decrementQuantity(
                                                              index),
                                                    ),
                                                    Text(
                                                      '${quantities[index]}',
                                                      style: TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.add),
                                                      onPressed: () =>
                                                          incrementQuantity(
                                                              index),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
      floatingActionButton: quantities.any((qty) => qty > 0)
          ? Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewcartProducts(
                          quantities: quantities,
                          imagePaths: imagePaths,
                          flavours: flavours,
                          initialQuantities: [],
                        ),
                      ),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 36, 197, 42),
                  child: Center(
                    child: Text(
                      '${quantities.reduce((a, b) => a + b)} items added   View Cart>',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
