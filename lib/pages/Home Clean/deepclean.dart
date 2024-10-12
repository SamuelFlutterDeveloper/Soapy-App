import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/Home%20Clean/homebooking.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/home.dart';
import 'package:soapy_app/pages/reviewbottom.dart';

class Deepclean extends StatefulWidget {
  const Deepclean({super.key});

  @override
  State<Deepclean> createState() => _DeepcleanState();
}

class _DeepcleanState extends State<Deepclean> {
  int _currentIndex = 0; // Index of the currently displayed widget

  void _onTabChange(int index) {
    setState(() {
      _currentIndex = index; // Update the index to show the selected widget
    });
  }

  final List<Map<String, String>> _images = [
    {
      'image': 'assets/images/five.jpg',
    },
    {
      'image': 'assets/images/first.png',
    },
    {
      'image': 'assets/images/sec.jpg',
    },
    {
      'image': 'assets/images/third.jpg',
    },
    {
      'image': 'assets/images/four.jpg',
    },
    {
      'image': 'assets/images/five.jpg',
    },
    // Add more items if needed
  ];

  // String _getUserName(int index) {
  //   List<String> userNames = [
  //     'John Doe',
  //     'Jane Smith',
  //     'Michael Johnson',
  //     'Emily Davis',
  //     'Chris Brown'
  //   ];
  //   return userNames[index];
  // }

  // List<String> _userReviews = [
  //   'Excellent service! Very thorough and professional.',
  //   'The cleaning team did an amazing job. Highly recommended!',
  //   'Punctual and efficient. My home looks spotless!',
  //   'Great attention to detail. I will definitely use this service again.',
  //   'Very satisfied with the service. Friendly staff and great results.'
  // ];

  // final TextEditingController _reviewController = TextEditingController();

  // void _addReview() {
  //   if (_reviewController.text.isNotEmpty) {
  //     setState(() {
  //       _userReviews.add(_reviewController.text);
  //       _reviewController
  //           .clear(); // Clear the text field after adding the review
  //     });
  //   }
  // }

  // List to store user reviews and usernames
  List<Map<String, String>> _userReviews = [];

  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Load username when the widget is initialized
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      setState(() {
        _usernameController.text = storedUsername;
      });
    }
    print("StoredUsername:-------------------------- $storedUsername");
  }

  void _addReview() {
    if (_reviewController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty) {
      setState(() {
        _userReviews.add({
          'username': _usernameController.text,
          'review': _reviewController.text,
        });
        _reviewController.clear(); // Clear the review text field
        // Do not clear the username text field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Responsive header image
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.3, // 30% of screen height
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/slider-1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Navigate back
                      },
                    ),
                  ),
                )
              ],
            ),

            SizedBox(height: 15),
            // Responsive title text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Home Cleaning",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width *
                      0.06, // Responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.star, // Star icon
                    color: Color.fromARGB(255, 255, 230, 0), // Yellow color
                    // size: MediaQuery.of(context).size.width * 0.07,
                    // Responsive icon size
                  ),
                  SizedBox(width: 5), // Space between icon and text
                  Expanded(
                    child: Text(
                      "4.8       No. 2 Rich central  | Indonesia", // Text next to the icon
                      style: TextStyle(
                        // fontSize: MediaQuery.of(context).size.width *
                        //     0.05, // Responsive font size
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 2, color: Colors.grey[300]),
            // Navigation buttons using GestureDetector
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _onTabChange(0),
                    child: _buildNavItem('About', 0),
                  ),
                  GestureDetector(
                    onTap: () => _onTabChange(1),
                    child: _buildNavItem('Gallery', 1),
                  ),
                  GestureDetector(
                    onTap: () => _onTabChange(2),
                    child: _buildNavItem('Review', 2),
                  ),
                ],
              ),
            ),
            Divider(thickness: 2, color: Colors.grey[300]),
            SizedBox(height: 5),
            // IndexedStack to show widgets based on the selected index
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  // About Us page
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Home Standard Clean',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.06, // Responsive font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Home cleaning services are designed to help you maintain a clean and organized living environment. Our team of experienced professionals provides thorough cleaning of all areas of your home, ensuring that every corner is spotless. We offer a range of services including dusting, vacuuming, mopping, and sanitizing surfaces to keep your home fresh and hygienic. Our cleaning products are eco-friendly and safe for children and pets, ensuring a healthy home environment. Whether you need a one-time deep clean or regular maintenance, our flexible scheduling options and customized cleaning plans can accommodate your needs. Experience the convenience and comfort of a professionally cleaned home with our top-notch cleaning services. We strive to exceed your expectations with every visit and provide a clean, welcoming space for you and your family to enjoy.',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.04, // Responsive font size
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Gallery page
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.5, // Adjust for image aspect ratio
                      ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        final item = _images[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(item['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Review page-----------

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 5),
                        // Username and review input fields
                        // TextField(
                        //   controller: _usernameController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: InputDecoration(
                        //     hintText: 'Username',
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: BorderSide(
                        //         color: Colors.black,
                        //         width: 1.0,
                        //       ),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: BorderSide(
                        //         color: Colors.black,
                        //         width: 1.0,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide: BorderSide(
                        //         color: Mycolor.maincolor,
                        //         width: 1.0,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _reviewController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Add Review',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Mycolor.maincolor,
                                width: 1.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: _addReview,
                              icon: Icon(
                                Icons.send,
                                color: Mycolor.maincolor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        // List of reviews
                        Expanded(
                          child: ListView.builder(
                            itemCount: _userReviews.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/images/MAN.png'),
                                  ),
                                  title: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.star,
                                        color: Color.fromARGB(255, 255, 230, 0),
                                        size: 16,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '4.8', // Example rating, replace with actual logic if needed
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        _userReviews[index]['username']!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    _userReviews[index]['review']!,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // SizedBox(
                    //     height: MediaQuery.of(context).size.height * 0.002),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Start from',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.03), // Small space between texts
                            Text(
                              '500.00 INR',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homebooking()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.08,
                              vertical: MediaQuery.of(context).size.height *
                                  0.015, // Reduced height
                            ),
                            child: Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width *
                0.05, // Responsive font size
            fontWeight: FontWeight.bold,
            color: Colors.black,
            // color: _currentIndex == index ? Colors.blue : Colors.black,
          ),
        ),
        if (_currentIndex == index)
          Container(
            margin: const EdgeInsets.only(top: 4),
            height: 8,
            width: 65,
            decoration: BoxDecoration(
              color: Mycolor.maincolor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
      ],
    );
  }
}
