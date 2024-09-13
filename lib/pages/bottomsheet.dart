import 'package:flutter/material.dart';
import 'package:soapy_app/pages/Home%20Clean/deepclean.dart';
import 'package:soapy_app/pages/customs/colors.dart';

class Bottomsheet extends StatefulWidget {
  const Bottomsheet({super.key});

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  Color _circleAvatarColor = Colors.white;

  void _closeSheet() {
    setState(() {
      _circleAvatarColor = Color.fromARGB(255, 230, 33, 33);
    });
    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.pop(context);
    });
  }

  final List<Map<String, String>> items = [
    {'image': 'assets/images/five.jpg', 'text': 'Home Standard Clean'},
    {'image': 'assets/images/first.png', 'text': 'Home Deep Clean'},
    {'image': 'assets/images/sec.jpg', 'text': 'Desting'},
    {'image': 'assets/images/third.jpg', 'text': 'Floor Mopping'},
    {'image': 'assets/images/four.jpg', 'text': 'Post Renovation'},
    {'image': 'assets/images/five.jpg', 'text': 'Toilet Clean'},
    // Add more items if needed
  ];

  void _onIconTap(int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Deepclean()));
        print('Home Standard Clean selected-----------------------');
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Deepclean()));
        // Action for Home Deep Clean
        print('Home Deep Clean selected----------------------');
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Deepclean()));
        // Action for Desting
        print('Desting selected------------------');
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Deepclean()));
        // Action for Floor Mopping
        print('Floor Mopping selected---------------');
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Deepclean()));
        // Action for Post Renovation
        print('Post Renovation selected---------------------');
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Deepclean()));

        // Action for Toilet Clean
        print('Toilet Clean selected------------------------');
        break;
      default:
        print('Unknown action------------------------------------');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                color: Mycolor.maincolor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "> Categories",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: _closeSheet,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: _circleAvatarColor,
                        child: const Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Container(
                    margin: const EdgeInsets.only(
                        bottom: 10), // Space between items
                    height: 87,
                    width: MediaQuery.of(context).size.width *
                        0.9, // 90% of screen width
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          // Image at the start
                          Container(
                            height: 65,
                            width: 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item['image']!,
                                fit: BoxFit
                                    .cover, // Change to cover for better aspect ratio
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 25), // Spacing between image and text
                          Expanded(
                            child: Text(
                              item['text']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _onIconTap(index),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:soapy_app/pages/Home%20Clean/deepclean.dart';
// import 'package:soapy_app/pages/customs/colors.dart';

// class Bottomsheet extends StatefulWidget {
//   const Bottomsheet({super.key});

//   @override
//   State<Bottomsheet> createState() => _BottomsheetState();
// }

// class _BottomsheetState extends State<Bottomsheet> {
//   Color _circleAvatarColor = Colors.white;

//   void _closeSheet() {
//     setState(() {
//       _circleAvatarColor = const Color.fromARGB(255, 230, 33, 33);
//     });
//     Future.delayed(const Duration(milliseconds: 200), () {
//       Navigator.pop(context);
//     });
//   }

//   final List<Map<String, String>> items = [
//     {'image': 'assets/images/five.jpg', 'text': 'Home Standard Clean'},
//     {'image': 'assets/images/first.png', 'text': 'Home Deep Clean'},
//     {'image': 'assets/images/sec.jpg', 'text': 'Desting'},
//     {'image': 'assets/images/third.jpg', 'text': 'Floor Mopping'},
//     {'image': 'assets/images/four.jpg', 'text': 'Post Renovation'},
//     {'image': 'assets/images/five.jpg', 'text': 'Toilet Clean'},
//     // Add more items if needed
//   ];

//   void _onIconTap(int index) {
//     switch (index) {
//       case 0:
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => Deepclean()));
//         print('Home Standard Clean selected');
//         break;
//       case 1:
//         print('Home Deep Clean selected');
//         break;
//       case 2:
//         print('Desting selected');
//         break;
//       case 3:
//         print('Floor Mopping selected');
//         break;
//       case 4:
//         print('Post Renovation selected');
//         break;
//       case 5:
//         print('Toilet Clean selected');
//         break;
//       default:
//         print('Unknown action');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(20),
//             bottomRight: Radius.circular(20),
//           ),
//           child: AppBar(
//             backgroundColor: Mycolor.maincolor,
//             elevation: 2,
//             title: Row(
//               children: const [
//                 Text(
//                   'Home',
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Text(
//                   "> Categories",
//                   style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 15),
//                 child: GestureDetector(
//                   onTap: _closeSheet,
//                   child: CircleAvatar(
//                     radius: 16,
//                     backgroundColor: _circleAvatarColor,
//                     child: const Icon(
//                       Icons.close_rounded,
//                       size: 20,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   return Container(
//                     margin: const EdgeInsets.only(
//                         bottom: 10), // Space between items
//                     height: 87,
//                     width: MediaQuery.of(context).size.width *
//                         0.9, // 90% of screen width
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           spreadRadius: 1,
//                           blurRadius: 5,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Row(
//                         children: [
//                           // Image at the start
//                           Container(
//                             height: 65,
//                             width: 65,
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.asset(
//                                 item['image']!,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                               width: 25), // Spacing between image and text
//                           Expanded(
//                             child: Text(
//                               item['text']!,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () => _onIconTap(index),
//                             child: Container(
//                               height: 30,
//                               width: 30,
//                               decoration: const BoxDecoration(
//                                 color: Colors.blue,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.arrow_forward_ios_rounded,
//                                 size: 17,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
