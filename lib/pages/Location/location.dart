// import 'package:flutter/material.dart';
// import 'package:soapy_app/pages/Location/location1.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class Location extends StatefulWidget {
//   const Location({super.key});

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {
//   String Address = '';
//   String locationMessage = ""; //Storing location message

//   Future<void> _getCurrentLocation() async {
//     //getCurrentLocation is a method

//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     //checking location is ennable
//     if (!serviceEnabled) {
//       // if location off give location message and go to location setting to turn on
//       setState(() {
//         locationMessage = "";
//         // "Location services are disabled. Please enable them in settings.";
//       });

//       // Optionally, open location settings for the user
//       await Geolocator.openLocationSettings();

//       return;
//     }

//     // Its permission while using a app accessing location permission
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       // if permission id denied give a location message and go location setting
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           locationMessage = "";
//           //"Location permissions are denied. Please grant permission in settings.";
//         });

//         // Optionally, open app settings for the user
//         await Geolocator.openAppSettings();

//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, show a message
//       setState(() {
//         locationMessage = "";
//         // "Location permissions are permanently denied. Please enable them in settings.";
//       });

//       // Optionally, open app settings for the user
//       await Geolocator.openAppSettings();

//       return;
//     }

//     // When permission is granted, get the current position
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     //desiredAccuracy is give correct level accuracy location

//     // Update UI with location info
//     setState(() {
//       locationMessage =
//           "Lat: ${position.latitude}, Long: ${position.longitude}";
//     });
//     print(position.latitude);
//     print(position.longitude);
//   }

//   Future<void> GetAdress(Position position) async {
//     List<Placemark> placemark =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemark);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: 190,
//           ),
//           Center(
//             child: Container(
//               height: 130,
//               width: 130,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey[200],
//               ),
//               child: Icon(
//                 Icons.location_on,
//                 color: Colors.teal[700],
//                 size: 60,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 35,
//           ),
//           Center(
//             child: Text(
//               'What is Your Location?',
//               style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Center(
//             child: Text(
//               'To Find Nearby Service Provider',
//               style: TextStyle(
//                 fontSize: 15,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(
//             height: 35,
//           ),
//           Center(
//             child: GestureDetector(
//               onTap: () async {
//                 Position? position = await Geolocator.getCurrentPosition(
//                     desiredAccuracy: LocationAccuracy.high);

//                 if (position != null) {
//                   await GetAdress(position);
//                 }
//               },
//               child: Container(
//                 height: 55,
//                 width: 350,
//                 decoration: BoxDecoration(
//                     color: Colors.teal[700],
//                     borderRadius: BorderRadius.circular(30)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 13),
//                   child: Text(
//                     'Allow Location Access',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Location1()));
//               },
//               child: Text(
//                 'Enter Location Manually',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.teal[700],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 25,
//           ),
//           Center(
//             child: Text(
//               locationMessage,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.redAccent,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//---------------------------------------------------------------------------------------------------------------------------//

// import 'package:flutter/material.dart';
// import 'package:soapy_app/pages/Location/location1.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class Location extends StatefulWidget {
//   const Location({super.key});

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {
//   String Address = '';
//   String locationMessage = ""; // Storing location message

//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() {
//         locationMessage =
//             "Location services are disabled. Please enable them in settings.";
//       });
//       await Geolocator.openLocationSettings();
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           locationMessage =
//               "Location permissions are denied. Please grant permission in settings.";
//         });
//         await Geolocator.openAppSettings();
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() {
//         locationMessage =
//             "Location permissions are permanently denied. Please enable them in settings.";
//       });
//       await Geolocator.openAppSettings();
//       return;
//     }

//     // Now that we have permission, get the current location
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       setState(() {
//         locationMessage =
//             "Lat: ${position.latitude}, Long: ${position.longitude}";
//       });

//       await GetAddress(position);
//     } catch (e) {
//       setState(() {
//         locationMessage = "Failed to get location: $e";
//       });
//     }
//   }

//   Future<void> GetAddress(Position position) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);
//       setState(() {
//         Address = placemarks.isNotEmpty
//             ? placemarks[0].toString()
//             : "No address found";
//         print(placemarks);
//       });
//     } catch (e) {
//       print("Error occurred while getting address: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(height: 190),
//           Center(
//             child: Container(
//               height: 130,
//               width: 130,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.grey[200],
//               ),
//               child: Icon(
//                 Icons.location_on,
//                 color: Colors.teal[700],
//                 size: 60,
//               ),
//             ),
//           ),
//           SizedBox(height: 35),
//           Center(
//             child: Text(
//               'What is Your Location?',
//               style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: 15),
//           Center(
//             child: Text(
//               'To Find Nearby Service Provider',
//               style: TextStyle(
//                 fontSize: 15,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: 35),
//           Center(
//             child: GestureDetector(
//               onTap: () async {
//                 await _getCurrentLocation();
//               },
//               child: Container(
//                 height: 55,
//                 width: 350,
//                 decoration: BoxDecoration(
//                     color: Colors.teal[700],
//                     borderRadius: BorderRadius.circular(30)),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 13),
//                   child: Text(
//                     'Allow Location Access',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 25),
//           Center(
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => Location1()));
//               },
//               child: Text(
//                 'Enter Location Manually',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.teal[700],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//           SizedBox(height: 25),
//           Center(
//             child: Text(
//               locationMessage,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.redAccent,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:soapy_app/pages/Location/manual%20location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/home.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  double? latitude;
  double? longitude;
  String Address = '';
  String locationMessage = ""; // Storing location message
  int? numberOfRooms1;
  // Future<void> _getBookingData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //    numberOfRooms1 = prefs.getInt('numberOfRooms') ?? 0;

  // }

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

// Its used to store a data in local
  Future<void> _saveLocationData(Position position, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);
    await prefs.setString('address', address);
    print(
        "Location data saved--------------------------"); // For debugging purposes
  }
  // After a storing a data after we want get the local store data for user interface

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitude = prefs.getDouble('latitude');
    double? longitude = prefs.getDouble('longitude');
    String? savedAddress = prefs.getString('address');
    print(
        "savedAddress --------------------------------------------'$savedAddress'");

    if (latitude != null && longitude != null && savedAddress != null) {
      setState(() {
        locationMessage = "Lat: $latitude, Long: $longitude";
        Address = savedAddress;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLocationData(); // Load saved location data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 190),
          Center(
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: Icon(
                Icons.location_on,
                color: Mycolor.maincolor,
                size: 60,
              ),
            ),
          ),
          SizedBox(height: 35),
          Center(
            child: Text(
              'What is Your Location?',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'To Find Nearby Service Provider',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 35),
          Center(
            child: GestureDetector(
              onTap: () async {
                await _getCurrentLocation();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                            // location: Address,
                            )),
                    (route) => false);
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: Mycolor.maincolor,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Text(
                    'Allow Location Access',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: GestureDetector(
              onTap: () {
                // await _getCurrentLocation();

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManualLocation()));
              },
              child: Text(
                'Enter Location Manually',
                style: TextStyle(
                  fontSize: 18,
                  color: Mycolor.maincolor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 25),
          // Center(
          //   child: Text(
          //     locationMessage,
          //     style: TextStyle(
          //       fontSize: 16,
          //       color: Colors.redAccent,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // if (Address.isNotEmpty)
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       'Address: $Address',
          //       style: TextStyle(
          //         fontSize: 16,
          //         color: Colors.black,
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
        ],
      ),
    );
  }
}
