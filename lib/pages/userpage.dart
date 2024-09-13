// import 'package:carousel_slider/carousel_slider.dart';

// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class Userpage extends StatefulWidget {
//   const Userpage({super.key});

//   @override
//   State<Userpage> createState() => _UserpageState();
// }

// class _UserpageState extends State<Userpage> {
//   final myitems = [
//     Image.asset('assets/images/slider-1.png'),
//     Image.asset('assets/images/SLIDER-2.png'),
//     Image.asset('assets/images/slider3.png'),
//   ];
//   int myCurrentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 21),
//             Stack(children: [
//               Container(
//                 child: CarouselSlider(
//                     options: CarouselOptions(
//                       autoPlay: true,
//                       height: 250,
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                       autoPlayAnimationDuration: Duration(milliseconds: 800),
//                       autoPlayInterval: Duration(seconds: 2),
//                       viewportFraction: 1.0,
//                       enlargeCenterPage: true,
//                       aspectRatio: 200,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           myCurrentIndex = index;
//                         });
//                       },
//                     ),
//                     items: myitems),
//               ),
//               Positioned(
//                 left: 20,
//                 top: 29,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 3,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: CircleAvatar(
//                     radius: 16,
//                     backgroundColor: Colors.white,
//                     child: GestureDetector(
//                       child: Icon(
//                         Icons.arrow_back,
//                         size: 25,
//                         color:
//                             Colors.black, // Set the color of the icon if needed
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 27,
//                 left: 260,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 3,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: CircleAvatar(
//                     radius: 16,
//                     backgroundColor: Colors.white,
//                     child: Icon(
//                       Icons.search,
//                       size: 25,
//                       color:
//                           Colors.black, // Set the color of the icon if needed
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 307,
//                 top: 27,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 3,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: CircleAvatar(
//                     radius: 16,
//                     backgroundColor: Colors.white,
//                     child: GestureDetector(
//                       child: Icon(
//                         Icons.share_outlined,
//                         size: 22,
//                         color:
//                             Colors.black, // Set the color of the icon if needed
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//             // SizedBox(
//             //   height: 5,
//             // ),
//             AnimatedSmoothIndicator(
//               activeIndex: myCurrentIndex,
//               count: myitems.length,
//               effect: WormEffect(
//                 dotHeight: 8,
//                 dotWidth: 8,
//                 spacing: 10,
//                 dotColor: const Color.fromARGB(255, 104, 98, 98),
//                 activeDotColor: Colors.grey.shade900,
//                 paintStyle: PaintingStyle.fill,
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 115),
//               child: Text(
//                 'Full Home Cleaning',
//                 style: TextStyle(
//                     fontSize: 23,
//                     fontWeight: FontWeight.bold,
//                     color: const Color.fromARGB(255, 0, 0, 0)),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30),
//               child: Row(
//                 children: [
//                   Icon(Icons.star),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   Text(
//                     '4 77 (900k boolings)',
//                     style: TextStyle(fontSize: 15, color: Colors.grey[800]),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 18,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 0),
//               child: Container(
//                 height: 60,
//                 width: 300,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 3,
//                       blurRadius: 5,
//                       offset: Offset(0, 3), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Saving 15% on all services',
//                       style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold,
//                           color: const Color.fromARGB(255, 0, 0, 0)),
//                       textAlign: TextAlign.center,
//                     ),
//                     // SizedBox(
//                     //   height: 10,
//                     // ),
//                     Text(
//                       'with your Plus membership',
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: const Color.fromARGB(255, 63, 59, 59)),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 37,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Container(
//                         height: 80,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: Colors.grey[200],
//                           image: DecorationImage(
//                               image: AssetImage(
//                                   'assets/images/furnied -Banglows.jpg'),
//                               fit: BoxFit.fill),
//                         ),
//                       ),
//                     ),
//                     // ElevatedButton(
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Text(
//                         'Furnished\napartment',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 15,
//                             color: const Color.fromARGB(255, 19, 18, 18)),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                       height: 80,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(7),
//                         color: Colors.grey[200],
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/unfurnsed.jpeg'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     // ElevatedButton(
//                     Text(
//                       'Unfurnished\napartment',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 15,
//                           color: const Color.fromARGB(255, 19, 18, 18)),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: Container(
//                         height: 80,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7),
//                             color: Colors.grey[200],
//                             image: DecorationImage(
//                                 image: AssetImage(
//                                     'assets/images/book my room.jpg'),
//                                 fit: BoxFit.fill)),
//                       ),
//                     ),
//                     // ElevatedButton(
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8),
//                       child: Text(
//                         'book\nby room',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 15,
//                             color: const Color.fromARGB(255, 19, 18, 18)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 17,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Container(
//                         height: 80,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7),
//                             color: Colors.grey[200],
//                             image: DecorationImage(
//                                 image: AssetImage('assets/images/Add-one.jpg'),
//                                 fit: BoxFit.fill)),
//                       ),
//                     ),
//                     // ElevatedButton(
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Text(
//                         'Furnished\nbungalow',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 15,
//                             color: const Color.fromARGB(255, 19, 18, 18)),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Container(
//                       height: 80,
//                       width: 100,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: Colors.grey[200],
//                           image: DecorationImage(
//                               image: AssetImage(
//                                   'assets/images/UNFURNISED BANGLOWS.png'))),
//                     ),
//                     // ElevatedButton(
//                     Text(
//                       'Unfurnished\nbungalow',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 15,
//                           color: const Color.fromARGB(255, 19, 18, 18)),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: Container(
//                         height: 80,
//                         width: 100,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(7),
//                             color: Colors.grey[200],
//                             image: DecorationImage(
//                                 image:
//                                     AssetImage('assets/images/unfurnied1.jpg'),
//                                 fit: BoxFit.fill)),
//                       ),
//                     ),
//                     // ElevatedButton(
//                     Text(
//                       'Add-ons',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 15,
//                           color: const Color.fromARGB(255, 19, 18, 18)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 34,
//               width: 110,
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(40)),
//               child: FloatingActionButton.extended(
//                 backgroundColor: const Color.fromARGB(221, 0, 0, 0),
//                 onPressed: () {},
//                 label: Text(
//                   'Menu',
//                   style: TextStyle(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//                 icon: Icon(
//                   Icons.menu,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
