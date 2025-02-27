import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/Location/location.dart';
import 'package:soapy_app/pages/app_page.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/home.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _useremailController = TextEditingController();
  final TextEditingController _uservechicalnumber = TextEditingController();
  File? _selectedImage;
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Load the stored username if it exists
  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _usernameController.text = prefs.getString('username') ?? '';
    _useremailController.text = prefs.getString('useremail') ?? '';
    _uservechicalnumber.text = prefs.getString('uservechical_number') ?? '';

    // Load Base64 image if exists
    String? base64Image = prefs.getString('user_image');
    if (base64Image != null) {
      setState(() {
        _base64Image = base64Image;
      });
    }
  }

  // Save user details and image
  void _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('useremail', _useremailController.text);
    await prefs.setString('uservechical_number', _uservechicalnumber.text);

    if (_base64Image != null) {
      await prefs.setString('user_image', _base64Image!);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  // Pick Image and Convert to Base64
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      // Convert image to Base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64String = base64Encode(imageBytes);

      setState(() {
        _selectedImage = imageFile;
        _base64Image = base64String;
      });

      // Save Base64 string in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_image', base64String);
    }
  }

  // Show modal bottom sheet for image selection
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera, color: Colors.blue),
              title: Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.image, color: Colors.blue),
              title: Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: sw,
              height: sh,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Login.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: sh * 0.18,
                  ), // Space at the top of the screen
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: sh * 0.08),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: _showImagePickerOptions,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _base64Image != null
                              ? MemoryImage(base64Decode(_base64Image!))
                              : AssetImage('assets/default_profile.png')
                                  as ImageProvider,
                          child: _base64Image == null
                              ? Icon(Icons.camera_alt,
                                  size: 30, color: Colors.white)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            _showImagePickerOptions();
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: sh * 0.03),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: _usernameController,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Mycolor.maincolor,
                        ),
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: _useremailController,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail,
                          color: Mycolor.maincolor,
                        ),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      controller: _uservechicalnumber,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.pedal_bike_rounded,
                          color: Mycolor.maincolor,
                        ),
                        hintText: 'Enter your Vechical Number',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27.0),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.034),
                  GestureDetector(
                    onTap: () {
                      if (_usernameController.text.isEmpty ||
                          _useremailController.text.isEmpty ||
                          _uservechicalnumber.text.isEmpty) {
                        // Show SnackBar if any field is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please fill all the fields"),
                            backgroundColor:
                                const Color.fromARGB(255, 158, 11, 0),
                          ),
                        );
                      } else {
                        // Save the username and navigate to the next screen
                        _saveUserData();
                        print("Entered Username: ${_usernameController.text}");
                        print("Entered Email: ${_useremailController.text}");
                        print(
                            "Entered Vehicle Number: ${_uservechicalnumber.text}");

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => AppPage()),
                          (route) => false,
                        );
                      }
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Mycolor.maincolor,
                          borderRadius: BorderRadius.circular(27)),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
