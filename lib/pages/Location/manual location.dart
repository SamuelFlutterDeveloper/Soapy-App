// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class ManualLocation extends StatefulWidget {
// //   const ManualLocation({super.key});

// //   @override
// //   State<ManualLocation> createState() => _Location1State();
// // }

// // class _Location1State extends State<ManualLocation> {
// //   String locationMessage = "";
// //   CameraPosition? _initialCameraPosition;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _getCurrentLocation();
// //   }

// //   Future<void> _getCurrentLocation() async {
// //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //     if (!serviceEnabled) {
// //       setState(() {
// //         locationMessage =
// //             "Location services are disabled. Please enable them in settings.";
// //       });
// //       await Geolocator.openLocationSettings();
// //       return;
// //     }

// //     LocationPermission permission = await Geolocator.checkPermission();
// //     if (permission == LocationPermission.denied) {
// //       permission = await Geolocator.requestPermission();
// //       if (permission == LocationPermission.denied) {
// //         setState(() {
// //           locationMessage =
// //               "Location permissions are denied. Please grant permission in settings.";
// //         });
// //         await Geolocator.openAppSettings();
// //         return;
// //       }
// //     }

// //     if (permission == LocationPermission.deniedForever) {
// //       setState(() {
// //         locationMessage =
// //             "Location permissions are permanently denied. Please enable them in settings.";
// //       });
// //       await Geolocator.openAppSettings();
// //       return;
// //     }

// //     // Now that we have permission, get the current location
// //     try {
// //       Position position = await Geolocator.getCurrentPosition(
// //           desiredAccuracy: LocationAccuracy.high);

// //       setState(() {
// //         locationMessage =
// //             "Lat: ${position.latitude}, Long: ${position.longitude}";
// //         _initialCameraPosition = CameraPosition(
// //           target: LatLng(position.latitude, position.longitude),
// //           zoom: 14.0, // Adjust zoom level as needed
// //         );

// //       });

// //     } catch (e) {
// //       setState(() {
// //         locationMessage = "Failed to get location: $e";
// //       });

// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: _initialCameraPosition == null
// //           ? Center(child: CircularProgressIndicator())
// //           : GoogleMap(
// //               myLocationEnabled: true,
// //               // myLocationButtonEnabled: true,
// //               initialCameraPosition: _initialCameraPosition!,
// //             ),
// //     );
// //   }
// // }

// //-0--------------------------------------------------------------------------------------
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class Location1 extends StatefulWidget {
// //   final double latitude;
// //   final double longitude;

// //   const Location1({
// //     Key? key,
// //     required this.latitude,
// //     required this.longitude,
// //   }) : super(key: key);

// //   @override
// //   State<Location1> createState() => _Location1State();
// // }

// // class _Location1State extends State<Location1> {
// //   static const _initialCameraPosition = CameraPosition(target: LatLng(widget.latitude, widget.longitude))

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: GoogleMap(initialCameraPosition: ),
// //     );
// //   }
// // }

// //--------------------------------------------------------------------------------------------

// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class ManualLocation extends StatefulWidget {
// //   const ManualLocation({super.key});

// //   @override
// //   State<ManualLocation> createState() => _ManualLocationState();
// // }

// // class _ManualLocationState extends State<ManualLocation> {
// //   late GoogleMapController mapController;

// //   final LatLng _center = LatLng(-23.5557714, -46.6395571);
// //   void _onMapCreated(GoogleMapController controller) {
// //     mapController = controller;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: GoogleMap(
// //           myLocationEnabled: true,
// //           // onMapCreated: _onMapCreated,
// //           initialCameraPosition: CameraPosition(target: _center, zoom: 11.0)),
// //     );
// //   }
// // }
// //-----------------------------------------------------------------------------------------//

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ManualLocation extends StatefulWidget {
  const ManualLocation({super.key});

  @override
  State<ManualLocation> createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  String locationMessage = "";
  CameraPosition? _initialCameraPosition;
  GoogleMapController? _controller;
  Set<Marker> _markers = {}; // Changed from Marker? to Set<Marker>

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        locationMessage =
            "Lat: ${position.latitude}, Long: ${position.longitude}";
        _initialCameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.0, // Adjust zoom level as needed
        );

        // Set the marker at the current location
        _markers.add(
          Marker(
            markerId: MarkerId("current_location"),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: InfoWindow(title: "You are here"),
          ),
        );
      });

      // Move the camera to the current location
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(_initialCameraPosition!),
      );
    } catch (e) {
      setState(() {
        locationMessage = "Failed to get location: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Manual Location'),
      // ),
      body: _initialCameraPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: _initialCameraPosition!,
              markers: _markers, // Use the set of markers
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
    );
  }
}

// -------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';

// class ManualLocation extends StatefulWidget {
//   const ManualLocation({super.key});

//   @override
//   State<ManualLocation> createState() => _ManualLocationState();
// }

// class _ManualLocationState extends State<ManualLocation> {
//   String locationMessage = "";
//   CameraPosition? _initialCameraPosition;
//   GoogleMapController? _controller;
//   Marker? _currentLocationMarker;
//   final Set<Marker> _markers = {};
//   final String _googleApiKey = "AIzaSyBuaaso8G5ZgmAGTd7I2Oz3q3iBx8HYqV0";
//   late GoogleMapsPlaces _places; // Initialize the GoogleMapsPlaces instance

//   @override
//   void initState() {
//     super.initState();
//     _places =
//         GoogleMapsPlaces(apiKey: _googleApiKey); // Initialize with API key
//     _getCurrentLocation();
//   }

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

//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       setState(() {
//         locationMessage =
//             "Lat: ${position.latitude}, Long: ${position.longitude}";
//         _initialCameraPosition = CameraPosition(
//           target: LatLng(position.latitude, position.longitude),
//           zoom: 14.0,
//         );

//         _currentLocationMarker = Marker(
//           markerId: MarkerId("current_location"),
//           position: LatLng(position.latitude, position.longitude),
//           infoWindow: InfoWindow(title: "You are here"),
//         );

//         _markers.add(_currentLocationMarker!);
//       });

//       _controller?.animateCamera(
//         CameraUpdate.newCameraPosition(_initialCameraPosition!),
//       );
//     } catch (e) {
//       setState(() {
//         locationMessage = "Failed to get location: $e";
//       });
//     }
//   }

//   Future<void> _handleSearch() async {
//     try {
//       Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: _googleApiKey,
//         mode: Mode.overlay, // Can be Mode.fullscreen too
//         language: "en",
//         components: [
//           Component(Component.country, "us")
//         ], // Example for country restriction
//       );

//       if (p != null) {
//         await _displayPrediction(p);
//       }
//     } catch (e) {
//       print("Error during search: $e");
//     }
//   }

//   Future<void> _displayPrediction(Prediction p) async {
//     try {
//       if (p.placeId == null) {
//         return; // Safeguard in case placeId is null
//       }

//       PlacesDetailsResponse detail =
//           await _places.getDetailsByPlaceId(p.placeId!);
//       final lat = detail.result.geometry!.location.lat;
//       final lng = detail.result.geometry!.location.lng;

//       _controller?.animateCamera(
//         CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0),
//       );

//       setState(() {
//         _markers.add(
//           Marker(
//             markerId: MarkerId(p.placeId!),
//             position: LatLng(lat, lng),
//             infoWindow: InfoWindow(title: detail.result.name),
//           ),
//         );
//       });
//     } catch (e) {
//       print("Error displaying prediction: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manual Location'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: _handleSearch,
//           ),
//         ],
//       ),
//       body: _initialCameraPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               initialCameraPosition: _initialCameraPosition!,
//               markers: _markers,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller = controller;
//               },
//             ),
//     );
//   }
// }
