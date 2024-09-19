import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Load the stored username if it exists
  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      _usernameController.text = storedUsername;
    }
    print("StoredUsername:-------------------------- $storedUsername");
  }

  // Save the username locally
  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    print(
        "Username saved:------------------------------ ${_usernameController.text}");
  }

  // Validator method
  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "Only alphabetic characters are allowed";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Login.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                  ), // Space at the top of the screen
                  Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.18),
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
                        hintText: 'Enter your username',
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
                      String? validationResult =
                          notEmpty(_usernameController.text);
                      if (validationResult != null) {
                        // Show the error message using ScaffoldMessenger
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(validationResult),
                            backgroundColor:
                                const Color.fromARGB(255, 158, 11, 0),
                          ),
                        );
                      } else {
                        // Save the username and navigate to the next screen
                        _saveUsername();
                        print(
                            "Entered Username:------------------------ ${_usernameController.text}");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => AppPage()),
                            (route) => false);
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
