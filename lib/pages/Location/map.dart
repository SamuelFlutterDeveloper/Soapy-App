// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SearchPlacesScreen extends StatefulWidget {
//   const SearchPlacesScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
// }

// const kGoogleApiKey = 'AIzaSyBMGbxkknDtYGx0dXTsUf_oKfzLbFOhkW4';
// final homeScaffoldKey = GlobalKey<ScaffoldState>();

// class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
//   static const CameraPosition initialCameraPosition =
//       CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);

//   Set<Marker> markersList = {};
//   late GoogleMapController googleMapController;
//   final Mode _mode = Mode.overlay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         title: const Text("Google Search Places"),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: initialCameraPosition,
//             markers: markersList,
//             mapType: MapType.normal,
//             onMapCreated: (GoogleMapController controller) {
//               googleMapController = controller;
//             },
//           ),
//           ElevatedButton(
//             onPressed: _handlePressButton,
//             child: const Text("Search Places"),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _handlePressButton() async {
//     try {
//       Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: kGoogleApiKey,
//         onError: onError,
//         mode: _mode,
//         language: 'en',
//         strictbounds: false,
//         types: [""],
//         decoration: InputDecoration(
//           hintText: 'Search',
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: BorderSide(color: Colors.white),
//           ),
//         ),
//         components: [
//           Component(Component.country, "pk"),
//           Component(Component.country, "usa"),
//         ],
//       );

//       if (p != null) {
//         displayPrediction(p);
//       } else {
//         _showErrorSnackBar('No place selected');
//       }
//     } catch (e) {
//       _showErrorSnackBar('An error occurred: $e');
//     }
//   }

//   void onError(PlacesAutocompleteResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//         title: 'Message',
//         message: response.errorMessage!,
//         contentType: ContentType.failure,
//       ),
//     ));
//   }

//   Future<void> displayPrediction(Prediction p) async {
//     final response = await http.get(Uri.parse(
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${p.placeId}&key=$kGoogleApiKey'));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);

//       if (data['status'] == 'OK') {
//         final result = data['result'];
//         final lat = result['geometry']['location']['lat'];
//         final lng = result['geometry']['location']['lng'];

//         setState(() {
//           markersList.clear();
//           markersList.add(Marker(
//             markerId: const MarkerId("0"),
//             position: LatLng(lat, lng),
//             infoWindow: InfoWindow(title: result['name']),
//           ));
//         });

//         googleMapController
//             .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
//       } else {
//         _showErrorSnackBar('Failed to fetch place details');
//       }
//     } else {
//       _showErrorSnackBar('Failed to fetch place details. Please try again.');
//     }
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.transparent,
//       content: AwesomeSnackbarContent(
//         title: 'Error',
//         message: message,
//         contentType: ContentType.failure,
//       ),
//     ));
//   }
// }
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({Key? key}) : super(key: key);

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

const kGoogleApiKey = 'AIzaSyBMGbxkknDtYGx0dXTsUf_oKfzLbFOhkW4';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(37.42796, -122.08574), zoom: 14.0);

  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: const Text("Google Search Places"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          Positioned(
            top: 15,
            left: 15,
            child: ElevatedButton(
              onPressed: _handlePressButton,
              child: const Text("Search Places"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    try {
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        components: [
          Component(Component.country, "pk"),
          Component(Component.country, "usa"),
        ],
      );

      if (p != null) {
        await displayPrediction(p);
      } else {
        _showErrorSnackBar('No place selected');
      }
    } catch (e) {
      _showErrorSnackBar('An error occurred: $e');
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));
  }

  Future<void> displayPrediction(Prediction p) async {
  final detailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=${p.placeId}&key=$kGoogleApiKey';

  final response = await http.get(Uri.parse(detailsUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // Print the entire response to the console
    print("Response data: $data");

    if (data['status'] == 'OK') {
      final result = data['result'];
      final lat = result['geometry']['location']['lat'];
      final lng = result['geometry']['location']['lng'];
      final placeName = result['name'];

      print("Place Name: $placeName");
      print("Latitude: $lat");
      
      print("Longitude: $lng");

      setState(() {
        markersList.clear();
        markersList.add(Marker(
          markerId: const MarkerId("0"),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: placeName),
        ));
      });

      googleMapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0),
      );
    } else {
      _showErrorSnackBar('Failed to fetch place details');
    }
  } else {
    _showErrorSnackBar('Failed to fetch place details. Please try again.');
  }
}


  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: message,
        contentType: ContentType.failure,
      ),
    ));
  }
}

