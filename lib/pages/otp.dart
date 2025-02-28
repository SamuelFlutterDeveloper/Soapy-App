import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/Location/location.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/username.dart';
//import 'home.dart';
// Ensure the correct import path

class Otp extends StatefulWidget {
  final String phone;
  final String countryCode;

  const Otp({Key? key, required this.countryCode, required this.phone})
      : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: const Color.fromARGB(255, 255, 255, 255),
      // borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Color.fromARGB(255, 223, 211, 211)),
      // boxShadow: [
      //   const BoxShadow(
      //     color: Color(0xffd9d9d9),
      //     spreadRadius: 5,
      //     blurRadius: 7,
      //     offset: Offset(0, 3),
      //   ),
      // ],
    ),
  );

  bool isPinComplete = false;
  String pin = "";
  String currentAddress = "Please wait....";
  String locality = "";
  Position? currentPosition;
  String address = '';
  String locationMessage = '';
  String Address = "Please wait....";

  String formatPhoneNumber(String phone, String countryCode) {
    if (phone.length < 3) {
      return '$countryCode $phone';
    }
    String maskedNumber =
        '*' * (phone.length - 2) + phone.substring(phone.length - 2);
    return '$countryCode $maskedNumber';
  }

//prime number
  void prime(int num) {
    int count = 0;
    for (int i = 1; i <= num; i++) {
      if (num % i == 0) {
        count++;
      }
    }
    if (count == 2) {
      print('the given number is prime $num');
    } else {
      print('the given number is not prime $num');
    }
  }

  //factorial

  void fact(int num) {
    int a = 1;
    for (int i = 1; i <= num; i++) {
      a *= i;
    }
    print("Factorial: $a");
  }

  //fibonacci

  void fibo(int num) {
    int first = 0;
    int second = 1;
    print('$first  \n $second');

    for (int i = 2; i <= num; i++) {
      int next = first + second;

      print(next);

      first = second;
      second = next;
    }
  }

  void palindrome(int num) {
    int original = num; // Store the original number
    int rev = 0;

    while (num > 0) {
      int n = num % 10;
      rev = rev * 10 + n;
      num = (num ~/ 10); // Integer division in Dart
    }

    if (original == rev) {
      print('The number is a palindrome');
    } else {
      print('The number is not a palindrome');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    String formattedPhoneNumber =
        formatPhoneNumber(widget.phone, widget.countryCode);
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: sh,
          width: sw,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Login.jpg'), fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: sh * 0.15,
              ),
              Text(
                'Verifying your\nCode',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: sh * 0.15,
              ),
              Text(
                'Please type the verification code \n sent to $formattedPhoneNumber',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 38,
              ),
              Pinput(
                length: 4,
                obscureText: true,
                obscuringCharacter: '*',
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(
                      color: Mycolor.maincolor,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    pin = value;
                    isPinComplete = value.length == 4;
                    print("${pin}----------------------------------------");
                  });
                },
              ),
              SizedBox(
                height: sh * 0.06,
              ),
              GestureDetector(
                onTap: isPinComplete
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Username()),
                        );
                      }
                    : null,
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    color:
                        isPinComplete ? Mycolor.maincolor : Mycolor.maincolor,
                  ),
                  child: const Center(
                    child: Text(
                      'Verify',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't get code",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      palindrome(2226);
                    },
                    child: Text(
                      'RESEND!',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 143, 0, 0)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
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

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          Address =
              "${place.thoroughfare},${place.street},${place.locality},${place.administrativeArea},${place.country},";
          locality = place.locality ?? "Unknown Locality";
          currentAddress = Address;
        });
        print(
            '${Address}-----------------------------------------------------');
      } else {
        setState(() {
          currentAddress = "No address found.";
        });
      }
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
    print(
        "Location data saved--------------------------"); // For debugging purposes
  }
}
