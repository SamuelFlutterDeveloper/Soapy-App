import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/Home%20Clean/homebooking.dart';
import 'dart:math';

import 'package:soapy_app/pages/customs/colors.dart';

class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  bool showThirdContainer = false;
  bool showDetailsFirst = false;
  bool showDetailsSecond = false;

  String? selectedArea;
  String? selectedRoomType;
  int? numberOfRooms;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? location;
  double? grandTotal;
  String phoneNumber = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadBookingData();
    _loadPhoneNumber();
    _loadUsername();
  }

  Future<void> _loadPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = prefs.getString('phone_number') ?? '';
    });
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      setState(() {
        username = storedUsername;
      });
    }
    print("StoredUsername:-------------------------- $storedUsername");
  }

  Future<void> _loadBookingData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      numberOfRooms = prefs.getInt('numberOfRooms') ?? 0;
      selectedRoomType = prefs.getString('roomType') ?? 'Not selected';
      selectedArea = prefs.getString('cleaningArea') ?? 'Not selected';

      // Retrieve and parse date
      String? dateString = prefs.getString('date');
      if (dateString != null && dateString.isNotEmpty) {
        try {
          selectedDate = DateFormat('yyyy-MM-dd').parse(dateString);
        } catch (e) {
          print('Error parsing date: $e');
          selectedDate = null;
        }
      }

      // Retrieve and parse time
      String? timeString = prefs.getString('time');
      if (timeString != null && timeString.isNotEmpty) {
        try {
          selectedTime = _parseTime(timeString);
        } catch (e) {
          print('Error parsing time: $e');
          selectedTime = null;
        }
      }

      // Retrieve location text
      location = prefs.getString('location') ?? 'Not provided';

      // Retrieve grand total
      grandTotal = prefs.getDouble('grandTotal') ?? 0.0;

      showThirdContainer = selectedRoomType != null &&
          selectedArea != null &&
          selectedDate != null &&
          selectedTime != null &&
          location != null &&
          grandTotal != null;
    });
  }

  TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(' ');
    final timePart = parts[0];
    final period = parts[1].toUpperCase();

    final timeParts = timePart.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    int hour24 = hour;
    if (period == 'PM' && hour < 12) {
      hour24 += 12;
    } else if (period == 'AM' && hour == 12) {
      hour24 = 0;
    }

    return TimeOfDay(hour: hour24, minute: minute);
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hourOfPeriod;
    final minute = timeOfDay.minute;
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  void _rebook() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homebooking()));
    // Implement your rebooking logic here
    print('Rebook button clicked');
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(27),
              bottomRight: Radius.circular(27),
            ),
          ),
          backgroundColor: Mycolor.maincolor,
          title: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: const Text(
              "Booking History",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookingContainer(
                screenWidth,
                roomType: 'Bathroom',
                cleaningArea: '50 sq ft (5 ft × 10 ft)',
                date: '7/7/2024',
                time: '02:00 AM',
                location: _getRandomLocation(),
                status: 'Completed',
                grandTotal: 470.0,
                serviceManName: _getRandomServiceManName(),
                serviceManPhone: _getRandomServiceManPhone(),
                serviceDate: '7/7/2024',
                serviceTime: '02:00 AM',
                showDetails: showDetailsFirst,
                onToggleDetails: () {
                  setState(() {
                    showDetailsFirst = !showDetailsFirst;
                  });
                },
                showRebookButton: true,
                onRebook: _rebook,
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildBookingContainer(
                screenWidth,
                roomType: 'Living Room',
                cleaningArea: '100 sq ft (10 ft × 10 ft)',
                date: '10/8/2024',
                time: '12:00 PM',
                location: _getRandomLocation(),
                status: 'Completed',
                grandTotal: _getRandomTotal(),
                serviceManName: _getRandomServiceManName(),
                serviceManPhone: _getRandomServiceManPhone(),
                serviceDate: '10/8/2024',
                serviceTime: '12:00 PM',
                showDetails: showDetailsSecond,
                onToggleDetails: () {
                  setState(() {
                    showDetailsSecond = !showDetailsSecond;
                  });
                },
                showRebookButton: true,
                onRebook: _rebook,
              ),
              SizedBox(height: screenHeight * 0.03),
              if (showThirdContainer) ...[
                _buildBookingContainer(
                  screenWidth,
                  roomType: selectedArea ?? 'Not Available',
                  cleaningArea: selectedRoomType ?? 'Not Available',
                  date: selectedDate != null
                      ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                      : 'Not Available',
                  time: selectedTime != null
                      ? _formatTime(selectedTime!)
                      : 'Not Available',
                  location: location ?? 'Not Available',
                  status: 'On Processing',
                  grandTotal: grandTotal ?? 0.0,
                  serviceManName:
                      username.isNotEmpty ? username : 'Not Available',
                  serviceManPhone:
                      phoneNumber.isNotEmpty ? phoneNumber : 'Not Available',
                  serviceDate: selectedDate != null
                      ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                      : 'Not Available',
                  serviceTime: selectedTime != null
                      ? _formatTime(selectedTime!)
                      : 'Not Available',
                  showDetails: showDetailsFirst,
                  onToggleDetails: () {
                    setState(() {
                      showDetailsFirst = !showDetailsFirst;
                    });
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingContainer(
    double screenWidth, {
    required String roomType,
    required String cleaningArea,
    required String date,
    required String time,
    required String location,
    required String status,
    required String serviceManName,
    required String serviceManPhone,
    required String serviceDate,
    required String serviceTime,
    double grandTotal = 0.0,
    bool showDetails = false,
    required VoidCallback onToggleDetails,
    bool showRebookButton = false,
    VoidCallback? onRebook,
  }) {
    Color statusColor;
    IconData statusIcon;

    if (status == 'Completed') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else {
      statusColor = Colors.orange;
      statusIcon = Icons.hourglass_empty;
    }

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(statusIcon, color: statusColor),
              const SizedBox(width: 8),
              Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Room Type: $roomType',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text('Cleaning Area: $cleaningArea'),
          const SizedBox(height: 5),
          Text('Date: $date'),
          const SizedBox(height: 5),
          Text('Time: $time'),
          const SizedBox(height: 5),
          Text('Location: $location'),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onToggleDetails,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  const Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    showDetails
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
          if (showDetails) ...[
            const SizedBox(height: 10),
            Text(
              'Service Man Name: $serviceManName',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text('Service Man Phone: $serviceManPhone'),
            const SizedBox(height: 5),
            Text('Service Date: $serviceDate'),
            const SizedBox(height: 5),
            Text('Service Time: $serviceTime'),
            const SizedBox(height: 10),
            Text(
              'Grand Total: $grandTotal INR',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
          if (showRebookButton)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: onRebook,
                child: const Text(
                  'Rebook',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Mycolor.maincolor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getRandomLocation() {
    final locations = [
      'Downtown Manhattan, New York, USA',
      'Shibuya, Tokyo, Japan',
      'Bondi Beach, Sydney, Australia',
      'South Kensington, London, UK',
      'Jumeirah, Dubai, UAE',
    ];
    return locations[Random().nextInt(locations.length)];
  }

  String _getRandomServiceManName() {
    final names = [
      'John Doe',
      'Jane Smith',
      'Michael Brown',
      'Emily Davis',
      'Sarah Wilson',
    ];
    return names[Random().nextInt(names.length)];
  }

  String _getRandomServiceManPhone() {
    final phones = [
      '+1234567890',
      '+0987654321',
      '+1122334455',
      '+5566778899',
      '+9988776655',
    ];
    return phones[Random().nextInt(phones.length)];
  }

  double _getRandomTotal() {
    return (Random().nextInt(1000) + 100).toDouble();
  }
}
