import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/payment/onlinepayment.dart'; // For date formatting

class Changehomebooking extends StatefulWidget {
  final String? selectedArea;
  final String? selectedRoomType;
  final int? numberOfRooms;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final String? location;

  const Changehomebooking({
    super.key,
    this.selectedArea,
    this.selectedRoomType,
    this.numberOfRooms,
    this.selectedDate,
    this.selectedTime,
    this.location,
  });

  @override
  State<Changehomebooking> createState() => _ChangehomebookingState();
}

class _ChangehomebookingState extends State<Changehomebooking> {
  late String? selectedArea;
  late String? selectedRoomType;
  late int? numberOfRooms;
  late DateTime? selectedDate;
  late TimeOfDay? selectedTime;
  late TextEditingController locationController;
  double? grandTotal;

  bool isAreaEditable = true;
  bool isRoomTypeEditable = true;
  bool isNumberOfRoomsEditable = true;
  bool isDateEditable = true;
  bool isTimeEditable = true;
  bool isLocationEditable = true;

  @override
  void initState() {
    super.initState();
    selectedArea = widget.selectedArea;
    selectedRoomType = widget.selectedRoomType;
    numberOfRooms = widget.numberOfRooms;
    selectedDate = widget.selectedDate;
    selectedTime = widget.selectedTime;
    locationController = TextEditingController(text: widget.location);
    _calculateGrandTotal(); // Calculate grandTotal on initialization
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _calculateGrandTotal(); // Recalculate grandTotal
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _calculateGrandTotal(); // Recalculate grandTotal
      });
    }
  }

  void _calculateGrandTotal() {
    final int baseValue = 500; // Base value for calculation
    final int subTotal = (numberOfRooms ?? 0) * baseValue; // Calculate subtotal
    final double gstPercentage = 2.0;
    final double gstAmount = subTotal * gstPercentage / 100; // Calculate GST
    final double discountPercentage = 5.0;
    final double discountAmount =
        subTotal * discountPercentage / 100; // Calculate Discount
    final double totalIncludingGst =
        subTotal + gstAmount; // Total including GST
    grandTotal = totalIncludingGst - discountAmount; // Calculate Grand Total
  }

  Future<void> _saveBookingData() async {
    _calculateGrandTotal(); // Ensure grandTotal is recalculated before saving

    final prefs = await SharedPreferences.getInstance();

    // Store data in SharedPreferences
    await prefs.setInt('numberOfRooms', numberOfRooms ?? 0);
    await prefs.setString(
        'roomType', selectedRoomType ?? ''); // Default to empty string
    await prefs.setString(
        'cleaningArea', selectedArea ?? ''); // Default to empty string

    // Save date in appropriate format
    await prefs.setString(
      'date',
      selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(selectedDate!)
          : '',
    );

    // Convert TimeOfDay to 12-hour format with AM/PM
    final timeString = selectedTime != null
        ? _formatTimeOfDay(selectedTime!)
        : ''; // Ensure this format matches retrieval format
    await prefs.setString('time', timeString);

    // Save location text
    await prefs.setString('location', locationController.text);

    // Save grand total, defaulting to 0.0 if null
    await prefs.setDouble('grandTotal', grandTotal ?? 0.0);

    print('Data is stored successfully');
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('h:mm a').format(dateTime);
  }

  Future<void> _getBookingData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // Retrieve and parse data from SharedPreferences
      numberOfRooms = prefs.getInt('numberOfRooms') ?? 0;
      selectedRoomType = prefs.getString('roomType') ??
          'Not selected'; // Default to 'Not selected'
      selectedArea = prefs.getString('cleaningArea') ??
          'Not selected'; // Default to 'Not selected'

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
          selectedTime = _parseTimeOfDay(timeString);
        } catch (e) {
          print('Error parsing time: $e');
          selectedTime = null;
        }
      }

      // Retrieve location text
      locationController.text = prefs.getString('location') ??
          'Not provided'; // Default to 'Not provided'

      // Retrieve grand total
      grandTotal = prefs.getDouble('grandTotal') ?? 0.0;
      print("$grandTotal-----------------------------");
    });
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
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
        return TimeOfDay(hour: hour24, minute: minute);
      }
    }
    return TimeOfDay(
        hour: 0, minute: 0); // Default to midnight if parsing fails
  }

  @override
  Widget build(BuildContext context) {
    final int baseValue = 500; // Base value for calculation
    final int subTotal = (numberOfRooms ?? 0) * baseValue; // Calculate subtotal
    final double gstPercentage = 2.0;
    final double gstAmount = subTotal * gstPercentage / 100; // Calculate GST
    final double discountPercentage = 5.0;
    final double discountAmount =
        subTotal * discountPercentage / 100; // Calculate Discount
    final double totalIncludingGst =
        subTotal + gstAmount; // Total including GST
    final double grandTotal =
        totalIncludingGst - discountAmount; // Calculate Grand Total
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
            0.2), // Adjust the height as needed
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35), // Radius for bottom corners
          ),
          child: AppBar(
            backgroundColor: Mycolor.maincolor, // AppBar background color
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08, // 8% from left
                right:
                    MediaQuery.of(context).size.width * 0.03, // 3% from right
                top: MediaQuery.of(context).size.height * 0.05, // 5% from top
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.025),
                    child: Container(
                      width: 100, // Fixed size for the square container
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage('assets/images/four.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.white, // Border color
                          width: 2, // Border width
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Home Deep Cleaning',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width *
                                0.05, // Responsive font size
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .black, // Change to white for better visibility on a blue background
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Color.fromARGB(
                                  255, 255, 230, 0), // Yellow star
                              size: MediaQuery.of(context).size.width *
                                  0.04, // Responsive icon size
                            ),
                            SizedBox(width: 5),
                            Text(
                              '4.8',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.04, // Responsive font size
                                  color: Colors.black,
                                  fontWeight: FontWeight
                                      .bold // Change to white for better visibility on a blue background
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Service Provider : SOAPY",
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width *
                                  0.038, // Responsive font size
                              color: Colors
                                  .black, // Change to white for better visibility on a blue background
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0, // Removes the shadow
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05, // 5% from left
              right: MediaQuery.of(context).size.width * 0.03, // 3% from right
              top: MediaQuery.of(context).size.height * 0.01, // 1% from top
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  "Booking Details",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Mycolor.maincolor),
                )),
                SizedBox(
                    height:
                        30), // Add space between the row and the new content

                // Cleaning Area Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Room Type',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAreaEditable = !isAreaEditable;
                        });
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (isAreaEditable)
                  DropdownButtonFormField<String>(
                    value: selectedArea,
                    hint: Text('Room Type'),

                    onChanged: (String? newValue) {
                      setState(() {
                        selectedArea = newValue;
                      });
                    },
                    items: <String>[
                      'Pooja Room',
                      'Guest Room',
                      'Study Room',
                      'Utility Room',
                      'Store Room',
                      'Main Hall',
                      'Living Room',
                      'Kitchen',
                      'Bathroom',
                      'Bedroom',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    isExpanded: true, // Ensures the dropdown takes full width
                  ),

                SizedBox(height: 20),

                // Room Type Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cleaning Area',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRoomTypeEditable = !isRoomTypeEditable;
                        });
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (isRoomTypeEditable)
                  DropdownButtonFormField<String>(
                    value: selectedRoomType,
                    hint: Text('Select Area'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRoomType = newValue;
                      });
                    },
                    items: <String>[
                      '50 sq ft (5 ft × 10 ft)',
                      '60 sq ft (6 ft × 10 ft)',
                      '80 sq ft (8 ft × 10 ft)',
                      '100 sq ft (10 ft × 10 ft)',
                      '120 sq ft (10 ft × 12 ft)',
                      '150 sq ft (10 ft × 15 ft)',
                      'above 200 sq ft (10 ft × 20 ft)',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    isExpanded: true, // Ensures the dropdown takes full width
                  ),

                SizedBox(height: 20),

                // Number of Rooms Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Number of Rooms',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNumberOfRoomsEditable = !isNumberOfRoomsEditable;
                        });
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (isNumberOfRoomsEditable)
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: numberOfRooms != null
                            ? numberOfRooms.toString()
                            : ''),
                    decoration: InputDecoration(
                      hintText: 'Enter Number of Rooms',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        numberOfRooms = int.tryParse(value);
                      });
                    },
                  ),

                SizedBox(height: 20),

                // Date Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDateEditable = !isDateEditable;
                        });
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (isDateEditable)
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(
                            text: selectedDate != null
                                ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                                : ''),
                        decoration: InputDecoration(
                          hintText: 'Select Date',
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                            size: 28,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                SizedBox(height: 20),

                // Time Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTimeEditable = !isTimeEditable;
                        });
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (isTimeEditable)
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: AbsorbPointer(
                      child: TextField(
                        controller: TextEditingController(
                            text: selectedTime != null
                                ? selectedTime!.format(context)
                                : ''),
                        decoration: InputDecoration(
                          hintText: 'Select Time',
                          suffixIcon: Icon(
                            Icons.access_alarm_outlined,
                            color: Colors.black,
                            size: 28,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                // SizedBox(height: 20),
                Divider(thickness: 2, color: Colors.grey[300]),

                // Sub Total Section
                Text(
                  'Sub Total:',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Room Qty: ${numberOfRooms ?? 0}*500',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '$subTotal INR',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'GST 2% (Include)',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${gstAmount.toStringAsFixed(2)} INR', // Show GST amount with 2 decimal places
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Space before Discount section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Discount 5%',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${discountAmount.toStringAsFixed(2)} INR', // Show Discount amount with 2 decimal places
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Space before Grand Total section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grand Total',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${grandTotal.toStringAsFixed(2)} INR', // Show Grand Total amount with 2 decimal places
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 2, color: Colors.grey[300]),

                SizedBox(height: 20),

                // Location Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sevice Location',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLocationEditable = !isLocationEditable;
                        });
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (isLocationEditable)
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: 'Enter Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      // Ensure grandTotal is calculated
                      await _saveBookingData(); // Save data before navigation
                      //await _getBookingData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Payment(
                            grandTotal: grandTotal ??
                                0.0, // Use null-coalescing operator
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Mycolor.maincolor),
                      child: Center(
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Text("$selectedArea"),
                // Text("$numberOfRooms")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
