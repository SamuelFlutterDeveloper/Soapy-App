import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:intl/intl.dart'; // Import DateFormat for parsing times
import 'package:soapy_app/pages/customs/colors.dart'; // Your custom colors

class Bookinghistory extends StatefulWidget {
  const Bookinghistory({super.key});

  @override
  State<Bookinghistory> createState() => _BookinghistoryState();
}

class _BookinghistoryState extends State<Bookinghistory> {
  bool isExpanded1 = false; // State for the first container
  bool isExpanded2 = false; // State for the second container
  bool isExpanded3 = false; // State for the third container

  bool showThirdContainer =
      false; // Flag to determine if the third container should be shown

  String? selectedArea;
  String? selectedRoomType;
  int? numberOfRooms;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? location;
  double? grandTotal;

  @override
  void initState() {
    super.initState();
    _loadBookingData(); // Load data when the widget is initialized
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
          final timeParts = timeString.split(' ');
          if (timeParts.length == 2) {
            final timePart = timeParts[0];
            final period = timeParts[1].toUpperCase(); // AM/PM
            final timePartsSplit = timePart.split(':');
            if (timePartsSplit.length == 2) {
              final hour = int.tryParse(timePartsSplit[0]) ?? 0;
              final minute = int.tryParse(timePartsSplit[1]) ?? 0;
              // Convert to 24-hour format if necessary
              int hour24 = hour;
              if (period == 'PM' && hour < 12) {
                hour24 += 12;
              } else if (period == 'AM' && hour == 12) {
                hour24 = 0;
              }
              selectedTime = TimeOfDay(hour: hour24, minute: minute);
            }
          }
        } catch (e) {
          print('Error parsing time: $e');
          selectedTime = null;
        }
      }

      // Retrieve location text
      location = prefs.getString('location') ?? 'Not provided';

      // Retrieve grand total
      grandTotal = prefs.getDouble('grandTotal') ?? 0.0;

      // Check if all required data for the third container is available
      showThirdContainer = selectedRoomType != null &&
          selectedArea != null &&
          selectedDate != null &&
          selectedTime != null &&
          location != null &&
          grandTotal != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(screenHeight * 0.1), // 10% of screen height
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(27),
              bottomRight: Radius.circular(27),
            ),
          ),
          backgroundColor: Mycolor.maincolor, // Custom color
          title: Padding(
            padding: EdgeInsets.only(
                top: screenHeight *
                    0.02), // Adjust padding to move the text down
            child: const Text(
              "Booking History",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true, // Ensures the title stays centered
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Overall padding for the body
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookingContainer(
                screenWidth,
                isExpanded1,
                () {
                  setState(() {
                    isExpanded1 = !isExpanded1;
                  });
                },
                roomType: 'Study Room',
                cleaningArea: '150 sq ft (10 ft × 15 ft)',
                date: '5/5/2024',
                time: '8:00 AM',
                location: '789 Pine St, Metroville',
                status: 'Completed',
              ),
              SizedBox(
                  height: screenHeight * 0.03), // Spacer between containers
              _buildBookingContainer(
                screenWidth,
                isExpanded2,
                () {
                  setState(() {
                    isExpanded2 = !isExpanded2;
                  });
                },
                roomType: 'Living Room',
                cleaningArea: '100 sq ft (10 ft × 10 ft)',
                date: '10/8/2024',
                time: '12:00 PM',
                location: '456 Elm St, Gotham',
                status: 'Completed',
              ),
              if (showThirdContainer) ...[
                SizedBox(
                    height: screenHeight * 0.03), // Spacer between containers
                _buildBookingContainer(
                  screenWidth,
                  isExpanded3,
                  () {
                    setState(() {
                      isExpanded3 = !isExpanded3;
                    });
                  },
                  roomType: selectedRoomType ?? 'Not Available',
                  cleaningArea: selectedArea ?? 'Not Available',
                  date: selectedDate != null
                      ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                      : 'Not Available',
                  time: selectedTime != null
                      ? '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')} ${selectedTime!.period == DayPeriod.am ? 'AM' : 'PM'}'
                      : 'Not Available',
                  location: location ?? 'Not Available',
                  status: 'On Processing',
                  grandTotal: grandTotal ?? 0.0,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingContainer(
    double screenWidth,
    bool isExpanded,
    VoidCallback onTap, {
    required String roomType,
    required String cleaningArea,
    required String date,
    required String time,
    required String location,
    required String status,
    double grandTotal = 0.0,
  }) {
    Color statusColor;
    IconData statusIcon;

    if (status == 'Completed') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else {
      statusColor = Colors.orange;
      statusIcon =
          Icons.hourglass_empty; // Or another icon indicating processing
    }

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2), // Horizontal and vertical shadow effect
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room Type',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            roomType,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20), // Space between Room Type and Cleaning Area
          Text(
            'Cleaning Area',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            cleaningArea,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20), // Space between Cleaning Area and Date
          Text(
            'Date',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            date,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20), // Space between Date and Time
          Text(
            'Time',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20), // Space between Time and Location
          Text(
            'Location',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            location,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20), // Space between Location and Status
          Text(
            'Status',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(
                statusIcon,
                color: statusColor,
              ),
              SizedBox(width: 10),
              Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  color: statusColor,
                ),
              ),
              Spacer(),
              if (grandTotal > 0)
                Text(
                  'Total: ₹${grandTotal.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          SizedBox(height: 20), // Space before expand/collapse
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  isExpanded ? 'Hide Details' : 'Show Details',
                  style: TextStyle(
                    fontSize: 16,
                    color: Mycolor.maincolor, // Your custom color
                  ),
                ),
                Icon(
                  isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                  color: Mycolor.maincolor, // Your custom color
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Additional Details:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'More detailed information about the booking would go here.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
