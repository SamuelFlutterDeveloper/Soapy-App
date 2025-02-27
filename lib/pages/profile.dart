import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/login.dart'; // Ensure to import the Login page

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  String phoneNumber = '';
  String address3 = '';
  String? _base64Image;
  final TextEditingController _uservechicalnumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Load the username when the page starts
    _loadPhoneNumber();
    _loadLocationData();
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      setState(() {
        _usernameController.text = storedUsername;
      });
    }
  }

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString('phone_number') ?? '';
    _uservechicalnumber.text = prefs.getString('uservechical_number') ?? '';

    String? base64Image = prefs.getString('user_image');

    if (base64Image != null) {
      setState(() {
        _base64Image = base64Image;
      });
    }
  }

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address3 = prefs.getString('address') ?? 'No address available';
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear the SharedPreferences cache

    // Navigate to login page and remove the current page from the stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Login()), // Ensure Login() is correctly defined
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(screenHeight * 0.4), // 40% of screen height
        child: AppBar(
          backgroundColor: Mycolor.maincolor, // Custom color
          flexibleSpace: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _base64Image != null
                      ? MemoryImage(
                          base64Decode(_base64Image!)) // If image is stored
                      : AssetImage('assets/images/MAN.png')
                          as ImageProvider, // Default image
                  child: _base64Image == null
                      ? Icon(Icons.camera_alt, size: 30, color: Colors.white)
                      : null,
                ),
                SizedBox(height: 10.0), // Space between image and name
                Text(
                  _usernameController.text,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Name text color
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_phone_sharp,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      phoneNumber,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Wrap(
                  alignment: WrapAlignment.center, // Center the content
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.white,
                    ),
                    // SizedBox(width: 5),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width *
                            0.7, // Constrain the text width to 70% of screen width
                      ),
                      child: Text(
                        address3,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow:
                            TextOverflow.visible, // Text should wrap if needed
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.directions_bike,
                      size: 20,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _uservechicalnumber.text,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(
                //       Icons.location_on,
                //       size: 30,
                //       color: Colors.white,
                //     ),
                //     SizedBox(width: 5),
                //     Flexible(
                //       child: Text(
                //         address3,
                //         textAlign: TextAlign.center,
                //         softWrap: true,
                //         style: const TextStyle(
                //           fontSize: 12.0,
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20), // Space before the logout button
                GestureDetector(
                  onTap: _logout,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Text('Profile Details Here'), // Add any other profile details
      ),
    );
  }
}
