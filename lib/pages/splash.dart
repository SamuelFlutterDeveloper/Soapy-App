// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:soapy_app/pages/login.dart';
// import 'package:flutter/material.dart';
// // import 'package:test2/pages/home.dart';
// // import 'package:test2/pages/login.dart';
// // import 'package:test2/pages/user.dart';

// // import 'package:test1/pages/home_page.dart';
// // import 'package:google_fonts/google_fonts.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     Timer(
//       Duration(seconds: 2),
//       () => Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => Login())),
//       //  Navigator.pushReplacement(
//       //     context, MaterialPageRoute(builder: (context) =>HomePage()))
//     );
//   }
//   String phoneNumber = '';
//   Future<void> _loadPhoneNumber() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       phoneNumber = prefs.getString('phone_number') ?? '';
//     });
//     print("$phoneNumber phone number save in local-----------------------------------------");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/images/splash.jpg"),
//                 fit: BoxFit.cover,
//               ),
//               // backgroundColor: Color.fromARGB(255, 67, 64, 251),
//               // body: Container(
//               //   height: double.infinity,
//               //   width: double.infinity,
//               //   alignment: Alignment.center,
//               //   child: Text(
//               //     "New App",
//               //     style: GoogleFonts.pacifico(
//               //       fontSize: 42,
//               //       fontWeight: FontWeight.bold,
//               //     ),
//               //   ),

//               // ),
//             )));
//   }
// }
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:soapy_app/pages/home.dart';
import 'package:soapy_app/pages/login.dart';
// import 'package:soapy_app/pages/home.dart'; // Uncomment this when HomePage is available.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString('phone_number') ?? '';

    // Check if the phone number exists
    if (phoneNumber.isEmpty) {
      // Go to Login page if phone number is empty
      Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login())),
      );
    } else {
      // Go to Home page if phone number exists
      Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Home())), // Replace HomePage with your actual home page widget.
      );
    }

    print(
        "$phoneNumber phone number saved in local-------------------------------------------");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
