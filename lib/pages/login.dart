// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:soapy_app/pages/customs/colors.dart';
// import 'package:soapy_app/pages/otp.dart';

// // import 'package:soapy_clean/util/validator.dart';

// class Validator {
//   static String? validateMobile(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter a Mobile number';
//     } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//       return "Please Enter a valid mobile number";
//     }
//     return null;
//   }
// }

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   String phoneNumber = '';
//   String selectedCountryCode = 'IN';
//   final _formKey = GlobalKey<FormState>(); // Key for the form

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/Login.jpg'),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Form(
//             key: _formKey, // Assigning the form key to the Form widget
//             child: Column(
//               children: [
//                 const SizedBox(height: 120),
//                 const Text(
//                   'Lets get your',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const Text(
//                   'Mobile Verified',
//                   style: TextStyle(
//                     fontSize: 38,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 115),
//                 Text(
//                   'Please enter your',
//                   style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   '10 digit mobile number to begin',
//                   style: TextStyle(fontSize: 17, color: Colors.grey[600]),
//                 ),
//                 const SizedBox(height: 28),
//                 SizedBox(
//                   height: 55,
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   child: IntlPhoneField(
//                     disableLengthCheck: true,
//                     initialCountryCode: selectedCountryCode,
//                     decoration: InputDecoration(
//                       hintText: "Phone Number",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       prefixIcon: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade300,
//                           borderRadius: const BorderRadius.horizontal(
//                             left: Radius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                     onChanged: (phone) {
//                       setState(() {
//                         phoneNumber =
//                             phone.number; // Store the phone number (10 digits)
//                         selectedCountryCode =
//                             phone.countryCode; // Update selected country code
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 7),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Don't worry! Your details are safe with us,",
//                       style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(width: 4),
//                     const Icon(
//                       Icons.verified_user,
//                       color: Colors.amber,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.06,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // Validate the phone number before navigating
//                     String? validationMessage =
//                         Validator.validateMobile(phoneNumber);
//                     if (validationMessage == null) {
//                       print(
//                           "${phoneNumber}--------------------------------------");
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Otp(
//                             countryCode: selectedCountryCode,
//                             phone: '$selectedCountryCode$phoneNumber',
//                           ),
//                         ),
//                       );
//                     } else {
//                       // Show an error message if the validation fails
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           backgroundColor:
//                               const Color.fromARGB(255, 173, 30, 20),
//                           content: Text(validationMessage),
//                         ),
//                       );
//                     }
//                   },
//                   child: Container(
//                     height: 55,
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(27),
//                       color: phoneNumber.length == 10
//                           ? Mycolor.maincolor
//                           // ? const Color.fromARGB(
//                           //     255, 21, 72, 211) // Active color
//                           : Mycolor.maincolor, // Disabled color
//                     ),
//                     child: const Center(
//                       child: Text(
//                         'GET OTP',
//                         style: TextStyle(fontSize: 19, color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/otp.dart';

// Validator class for mobile number validation
class Validator {
  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Mobile number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Please Enter a valid mobile number";
    }
    return null;
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNumber = '';
  String selectedCountryCode = 'IN';
  final _formKey = GlobalKey<FormState>(); // Key for the form

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber(); // Load phone number when the widget is initialized
  }

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = prefs.getString('phone_number') ?? '';
    });
    print(
        "$phoneNumber phone number save in local-----------------------------------------");
  }

  Future<void> _savePhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone_number', phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: sh,
          width: sw,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Login.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Form(
            key: _formKey, // Assigning the form key to the Form widget
            child: Column(
              children: [
                SizedBox(
                  height: sh * 0.15,
                ),
                const Text(
                  'Lets get your',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Mobile Verified',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: sh * 0.15,
                ),
                Text(
                  'Please enter your',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '10 digit mobile number to begin',
                  style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: IntlPhoneField(
                    disableLengthCheck: true,
                    initialCountryCode: selectedCountryCode,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (phone) {
                      setState(() {
                        phoneNumber =
                            phone.number; // Store the phone number (10 digits)
                        selectedCountryCode =
                            phone.countryCode; // Update selected country code
                      });
                    },
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't worry! Your details are safe with us,",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.verified_user,
                      color: Colors.amber,
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                GestureDetector(
                  onTap: () async {
                    // Validate the phone number before navigating
                    String? validationMessage =
                        Validator.validateMobile(phoneNumber);
                    if (validationMessage == null) {
                      // Save the phone number locally
                      await _savePhoneNumber();

                      print(
                          "${phoneNumber}--------------------------------------");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Otp(
                            countryCode: selectedCountryCode,
                            phone: '$selectedCountryCode$phoneNumber',
                          ),
                        ),
                      );
                    } else {
                      // Show an error message if the validation fails
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              const Color.fromARGB(255, 173, 30, 20),
                          content: Text(validationMessage),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      color: phoneNumber.length == 10
                          ? Mycolor.maincolor
                          : Mycolor
                              .maincolor, // Adjust color based on phone number length
                    ),
                    child: const Center(
                      child: Text(
                        'GET OTP',
                        style: TextStyle(fontSize: 19, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
