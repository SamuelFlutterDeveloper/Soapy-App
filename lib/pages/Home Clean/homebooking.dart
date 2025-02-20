import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import to format and handle date selection
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/Home%20Clean/changehomebooking.dart';
import 'package:soapy_app/pages/customs/colors.dart';

class Homebooking extends StatefulWidget {
  const Homebooking({super.key});

  @override
  State<Homebooking> createState() => _HomebookingState();
}

class _HomebookingState extends State<Homebooking> {
  String? selectedArea;
  String? selectedRoomType;
  String? selectedDuration;
  int? numberOfRooms;
  String address1 = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLocationData();
  }

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address1 = prefs.getString('address')!;
    print('address1---------------------->$address1');
  }

  void _useCurrentLocation() {
    setState(() {
      locationController.text = address1;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

// this for validator to go next page
  void _continueToNextPage() {
    if (selectedArea == null ||
        selectedDuration == null ||
        selectedRoomType == null ||
        numberOfRooms == null ||
        selectedDate == null ||
        selectedTime == null ||
        locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 173, 30, 20),
          content: Text('Please fill in all the required fields.'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Changehomebooking(
            selectedArea: selectedArea,
            selectedRoomType: selectedRoomType,
            numberOfRooms: numberOfRooms,
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            location: locationController.text,
            selectedDuration: selectedDuration,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height *
            0.2), // Adjust height as needed
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), // Radius for bottom corners
          ),
          child: AppBar(
            backgroundColor:
                Mycolor.maincolor, // Background color of the AppBar
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
                      width: 95, // Fixed size for the square container
                      height: 95,
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
                            color: Colors.black,
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
                              ),
                            ),
                            SizedBox(width: 50),
                            Text(
                              'Price Catalog',
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width *
                                    0.04, // Responsive font size
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // elevation: 0, // Removes the shadow
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05, // 5% from left
              right: MediaQuery.of(context).size.width * 0.03, // 3% from right
              top: MediaQuery.of(context).size.height * 0.05, // 5% from top
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height:
                        10), // Add space between the row and the new content
                Text(
                  'Room Type',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  // Adjust width as needed
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
                  ),
                  child: DropdownButtonFormField2<String>(
                    value: selectedArea,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Removes default border
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    hint: Text('Room Type'),
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
                      'Entire House',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedArea = newValue;
                      });
                    },
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200, // Adjust dropdown height
                      width: 150, // Adjust dropdown width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white, // Background color
                      ),
                    ),
                    isExpanded: false, // Prevents full width expansion
                  ),
                ),

                SizedBox(height: 20), // Add space between the dropdowns
                Text(
                  'Cleaning Area',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  // Adjust width as needed
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
                  ),
                  child: DropdownButtonFormField2<String>(
                    value: selectedRoomType,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Removes default border
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    hint: Text('Selected Area'),
                    items: <String>[
                      '50 sq ft (5 ft × 10 ft) ',
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
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRoomType = newValue;
                      });
                    },
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200, // Adjust dropdown height
                      width: 250, // Adjust dropdown width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white, // Background color
                      ),
                    ),
                    isExpanded: false, // Prevents full width expansion
                  ),
                ),
                SizedBox(
                    height:
                        20), // Add space between the dropdown and the new content
                Text(
                  'Number of Rooms',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Number of Rooms',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey, // Border color
                          width: 1.0, // Border thickness
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey
                              .shade300, // Border color for the enabled state
                          width: 1.0, // Border thickness
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Mycolor
                              .maincolor, // Border color for the focused state
                          width: 1.0, // Border thickness
                        ),
                      ),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        numberOfRooms = int.tryParse(value);
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  'Duration',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                Container(
                  // Adjust width as needed
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
                  ),
                  child: DropdownButtonFormField2<String>(
                    value: selectedDuration,
                    decoration: InputDecoration(
                      border: InputBorder.none, // Removes default border
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    hint: Text('Duration'),
                    items: <String>[
                      'Weekly',
                      'Monthly',
                      'Quarterly',
                      'Yearly',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDuration = newValue;
                      });
                    },
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200, // Adjust dropdown height
                      width: 250, // Adjust dropdown width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.white, // Background color
                      ),
                    ),
                    isExpanded: false, // Prevents full width expansion
                  ),
                ),
                SizedBox(height: 20),

                // Row for Date and Time
                Row(
                  children: [
                    // Date TextField
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => _selectDate(context),
                            child: AbsorbPointer(
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: selectedDate != null
                                      ? DateFormat.yMd().format(selectedDate!)
                                      : 'dd/mm/yyyy',
                                  suffixIcon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey, // Border color
                                      width: 1.0, // Border thickness
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade300, // Border color for the enabled state
                                      width: 1.0, // Border thickness
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Mycolor
                                          .maincolor, // Border color for the focused state
                                      width: 1.0, // Border thickness
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 20), // Space between Date and Time TextFields
                    // Time TextField
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => _selectTime(context),
                            child: AbsorbPointer(
                              child: TextField(
                                readOnly: true,
                                decoration: InputDecoration(
                                  hintText: selectedTime != null
                                      ? selectedTime!.format(context)
                                      : '00:00 AM',
                                  suffixIcon: Icon(
                                    Icons.access_alarm_outlined,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey, // Border color
                                      width: 1.0, // Border thickness
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade300, // Border color for the enabled state
                                      width: 1.0, // Border thickness
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Mycolor
                                          .maincolor, // Border color for the focused state
                                      width: 1.0, // Border thickness
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Space between Time and Location

                // Location Text
                Text(
                  'Location',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 10),

                TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: 'Enter Location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border thickness
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey
                            .shade300, // Border color for the enabled state
                        width: 1.0, // Border thickness
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Mycolor
                            .maincolor, // Border color for the focused state
                        width: 1.0, // Border thickness
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical:
                          35.0, // Adjust the vertical padding inside the TextField
                      horizontal: 15.0,
                    ),
                  ),
                ),
                SizedBox(height: 10), // Space between the TextField and the row

                // Row aligned to start at 60% of the screen width
                Align(
                  alignment:
                      Alignment.centerRight, // Aligns the row to the right side
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width *
                          0.07, // Adjust if needed
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Minimize the row size to its children
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Mycolor
                              .maincolor, // You can change the color if needed
                          size: MediaQuery.of(context).size.width *
                              0.07, // Adjust the size if needed
                        ),
                        SizedBox(width: 10), // Space between icon and text
                        GestureDetector(
                          onTap: _useCurrentLocation,
                          child: Text(
                            'Use Current Location',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.040,
                              fontWeight: FontWeight.bold,
                              color: Mycolor
                                  .maincolor, // You can change the color if needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: _continueToNextPage, // Calls _continueToNextPage
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Mycolor.maincolor,
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
