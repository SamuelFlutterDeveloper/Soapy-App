// import 'package:flutter/material.dart';
// import 'package:soapy_app/pages/customs/colors.dart';

// class Reviewbottom extends StatefulWidget {
//   const Reviewbottom({super.key});

//   @override
//   State<Reviewbottom> createState() => _ReviewbottomState();
// }

// class _ReviewbottomState extends State<Reviewbottom> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.4,
//       child: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: TextField(
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//             hintText: 'Add Review',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Colors.black, // Border color
//                 width: 1.0, // Border thickness
//               ),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Colors.black, // Border color for the enabled state
//                 width: 1.0, // Border thickness
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(
//                 color: Mycolor.maincolor, // Border color for the focused state
//                 width: 1.0, // Border thickness
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Reviewbottom extends StatefulWidget {
//   const Reviewbottom({super.key});

//   @override
//   State<Reviewbottom> createState() => _ReviewbottomState();
// }

// class _ReviewbottomState extends State<Reviewbottom> {
//   @override
//   Widget build(BuildContext context) {
//     // String Name = '';
//      void _loadUsername() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? Name = prefs.getString('username');
   
//     print("StoredUsername:-------------------------- $Name");
//   }
   
//     String _getUserName(int index) {
//       List<String> userNames = [
//         'John Doe',
//         'Jane Smith',
//         'Michael Johnson',
//         'Emily Davis',
//         'Chris Brown'
//       ];
//       return userNames[index];
//     }

//     String _getUserReview(int index) {
//       List<String> userReviews = [
//         'Excellent service! Very thorough and professional.',
//         'The cleaning team did an amazing job. Highly recommended!',
//         'Punctual and efficient. My home looks spotless!',
//         'Great attention to detail. I will definitely use this service again.',
//         'Very satisfied with the service. Friendly staff and great results.'
//       ];
//       return userReviews[index];
//     }

//     return Scaffold(
//       body: Column(
//         children: [
//           // Review page-----------

//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 // Row for Reviews and Add Reviews
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Reviews',
//                       style: TextStyle(
//                         fontSize: MediaQuery.of(context).size.width * 0.05,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             // showModalBottomSheet(
//                             //   context: context,
//                             //   builder: (context) => Reviewbottom(),
//                             // );
//                           },
//                           child: Icon(
//                             Icons.add, // Add review icon
//                             color: Colors.blue,
//                           ),
//                         ),
//                         SizedBox(width: 5), // Space between icon and text
//                         GestureDetector(
//                           onTap: () {
//                             // showModalBottomSheet(
//                             //   context: context,
//                             //   builder: (context) => Reviewbottom(),
//                             // );
//                           },
//                           child: Text(
//                             'Add Review',
//                             style: TextStyle(
//                               fontSize:
//                                   MediaQuery.of(context).size.width * 0.05,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 15),

//                 // List of reviews------------------------
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: 5, // Number of reviews
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: AssetImage(
//                                 'assets/images/MAN.png'), // Avatar image
//                           ),
//                           title: Row(
//                             children: [
//                               SizedBox(
//                                   width: 5), // Space between avatar and star
//                               Icon(
//                                 Icons.star,
//                                 color: Color.fromARGB(
//                                     255, 255, 230, 0), // Yellow star
//                                 size: 16,
//                               ),
//                               SizedBox(
//                                   width: 5), // Space between star and rating
//                               Text(
//                                 '4.8',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(
//                                   width: 10), // Space between rating and name
//                               Text(
//                                 _getUserName(index),
//                                 // Display user name
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18),
//                               ),
//                             ],
//                           ),
//                           subtitle: Text(
//                             _getUserReview(index), // Display user review
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Reviewbottom extends StatefulWidget {
//   const Reviewbottom({super.key});

//   @override
//   State<Reviewbottom> createState() => _ReviewbottomState();
// }

// class _ReviewbottomState extends State<Reviewbottom> {
//   final TextEditingController _reviewController = TextEditingController();
//   double _userRating = 0;
//   List<String> _userReviews = [];
//   List<double> _userRatings = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadStoredReviews(); // Load saved reviews
//   }

//   // Load saved reviews and ratings from SharedPreferences
//   void _loadStoredReviews() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? storedReviews = prefs.getStringList('userReviews');
//     List<String>? storedRatings = prefs.getStringList('userRatings');
//     if (storedReviews != null && storedRatings != null) {
//       setState(() {
//         _userReviews = storedReviews;
//         _userRatings =
//             storedRatings.map((rating) => double.parse(rating)).toList();
//       });
//     }
//   }

//   // Save the review and rating to SharedPreferences
//   void _saveReview() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList('userReviews', _userReviews);
//     await prefs.setStringList(
//         'userRatings', _userRatings.map((rating) => rating.toString()).toList());
//   }

//   // Add a new review and update the list
//   void _addReview() {
//     setState(() {
//       _userReviews.add(_reviewController.text);
//       _userRatings.add(_userRating);
//     });
//     _saveReview();
//     _reviewController.clear();
//     _userRating = 0;
//   }

//   // Username retrieval (for demonstration purposes)
//   String _getUserName() {
//     return 'Local Username'; // You can replace this with a username from SharedPreferences
//   }

//   // Dynamic List of Reviews
//   String _getUserReview(int index) {
//     return _userReviews[index];
//   }

//   double _getUserRating(int index) {
//     return _userRatings[index];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 // Row for Reviews and Add Reviews
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Reviews',
//                       style: TextStyle(
//                         fontSize: MediaQuery.of(context).size.width * 0.05,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             // Open a modal or show input fields below
//                             setState(() {});
//                           },
//                           child: Icon(
//                             Icons.add, // Add review icon
//                             color: Colors.blue,
//                           ),
//                         ),
//                         SizedBox(width: 5), // Space between icon and text
//                         GestureDetector(
//                           onTap: () {
//                             // Open the form for adding a review
//                             setState(() {});
//                           },
//                           child: Text(
//                             'Add Review',
//                             style: TextStyle(
//                               fontSize:
//                                   MediaQuery.of(context).size.width * 0.05,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 15),

//                 // Input fields for adding a new review
//                 TextField(
//                   controller: _reviewController,
//                   decoration: InputDecoration(
//                     hintText: 'Enter your review',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Rate our service:',
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 Row(
//                   children: List.generate(5, (index) {
//                     return IconButton(
//                       icon: Icon(
//                         index < _userRating
//                             ? Icons.star
//                             : Icons.star_border_outlined,
//                         color: Colors.yellow,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _userRating = index + 1.0;
//                         });
//                       },
//                     );
//                   }),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_reviewController.text.isNotEmpty &&
//                         _userRating > 0) {
//                       _addReview();
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                               'Please provide both a review and a rating.'),
//                           backgroundColor: Colors.red,
//                         ),
//                       );
//                     }
//                   },
//                   child: Text('Submit Review'),
//                 ),
//                 SizedBox(height: 15),

//                 // List of reviews------------------------
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: _userReviews.length, // Number of reviews
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundImage: AssetImage(
//                                 'assets/images/MAN.png'), // Avatar image
//                           ),
//                           title: Row(
//                             children: [
//                               SizedBox(
//                                   width: 5), // Space between avatar and star
//                               Icon(
//                                 Icons.star,
//                                 color: Color.fromARGB(
//                                     255, 255, 230, 0), // Yellow star
//                                 size: 16,
//                               ),
//                               SizedBox(
//                                   width: 5), // Space between star and rating
//                               Text(
//                                 _getUserRating(index).toStringAsFixed(1),
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(
//                                   width: 10), // Space between rating and name
//                               Text(
//                                 _getUserName(), // Static or dynamic user name
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18),
//                               ),
//                             ],
//                           ),
//                           subtitle: Text(
//                             _getUserReview(index), // Display user review
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
