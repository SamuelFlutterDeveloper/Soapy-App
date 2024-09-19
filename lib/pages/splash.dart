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
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:soapy_app/pages/home.dart';
// import 'package:soapy_app/pages/login.dart';
// // import 'package:soapy_app/pages/home.dart'; // Uncomment this when HomePage is available.

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   String phoneNumber = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadPhoneNumber();
//   }

//   Future<void> _loadPhoneNumber() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     phoneNumber = prefs.getString('phone_number') ?? '';

//     // Check if the phone number exists
//     if (phoneNumber.isEmpty) {
//       // Go to Login page if phone number is empty
//       Timer(
//         Duration(seconds: 2),
//         () => Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => Login())),
//       );
//     } else {
//       // Go to Home page if phone number exists
//       Timer(
//         Duration(seconds: 2),
//         () => Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     Home())), // Replace HomePage with your actual home page widget.
//       );
//     }

//     print(
//         "$phoneNumber phone number saved in local-------------------------------------------");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/splash.jpg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:soapy_app/pages/app_page.dart';
import 'package:soapy_app/pages/home.dart';
import 'package:soapy_app/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String phoneNumber = '';
  String locationMessage = '';
  String Address = '';

  @override
  void initState() {
    super.initState();
    _loadPhoneNumber();
  }

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString('phone_number') ?? '';

    // Fetch the current location
    await _getCurrentLocation();

    // Navigate to the appropriate page after checking phone number and fetching location
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => phoneNumber.isEmpty ? Login() : AppPage(),
        ),
      ),
    );

    print(
        "$phoneNumber phone number saved in local-------------------------------------------");
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage =
            "Location services are disabled. Please enable them in settings.";
      });
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage =
              "Location permissions are denied. Please grant permission in settings.";
        });
        await Geolocator.openAppSettings();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage =
            "Location permissions are permanently denied. Please enable them in settings.";
      });
      await Geolocator.openAppSettings();
      return;
    }

    // Now that we have permission, get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        locationMessage =
            "Lat: ${position.latitude}, Long: ${position.longitude}";
      });

      await _getAddressFromCoordinates(position);
      await _saveLocationData(position, Address); // Save the data locally
    } catch (e) {
      setState(() {
        locationMessage = "Failed to get location: $e";
      });
    }
  }

  Future<void> _getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        Address =
            "${place.street},${place.thoroughfare},${place.locality}, ${place.postalCode}";
      });
      print(Address); // For debugging purposes
    } catch (e) {
      print("Error occurred while getting address: $e");
      setState(() {
        Address = "Failed to get address";
      });
    }
  }

  Future<void> _saveLocationData(Position position, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);
    await prefs.setString('address', address);
    print("Location data saved--------------------------"); // For debugging purposes
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
