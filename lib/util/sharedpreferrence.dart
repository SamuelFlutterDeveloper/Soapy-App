
  


import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
   String Address = '';
  String locationMessage = ""; // Storing location message

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
          desiredAccuracy: LocationAccuracy.high);

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
            "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
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
        "Location data saved--------------------------"); 
  }
  // After a storing a data after we want get the local store data for user interface 

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitude = prefs.getDouble('latitude');
    double? longitude = prefs.getDouble('longitude');
    String? savedAddress = prefs.getString('address');
    print("Location --------------------------------------------'$longitude'");

    if (latitude != null && longitude != null && savedAddress != null) {
      setState(() {
        locationMessage = "Lat: $latitude, Long: $longitude";
        Address = savedAddress;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
