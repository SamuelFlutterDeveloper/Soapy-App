import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:soapy_app/Cleaning/cleaning_main_page.dart';
import 'package:soapy_app/electrician/electrician_main_page.dart';
import 'package:soapy_app/pages/Location/location.dart';
import 'package:soapy_app/pages/bookinghistory.dart';
import 'package:soapy_app/pages/bottomsheet.dart';
import 'package:soapy_app/pages/customs/colors.dart';

import 'package:soapy_app/pages/profile.dart';
import 'package:soapy_app/pest%20control/pest_control_main.dart';
import 'package:soapy_app/plumping/pluming_main_page.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    _loadLocationData(); // Load saved location data when the widget is initialized
    _loadUsername(); // Load the username when the app starts
  }

  Future<void> _loadLocationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address2 = prefs.getString('address')!;
    print('address---------------------->$address2');
  }

  // Create a GlobalKey for the ScaffoldState
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _usernameController = TextEditingController();

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    if (storedUsername != null) {
      setState(() {
        _usernameController.text = storedUsername;
      });
    }
    print("StoredUsername:-------------------------- $storedUsername");
  }

  int myCurrentIndex = 0;
  String address2 = '';

  bool _isHomeSelected = false;
  bool _isVillasSelected = false;
  bool _isApartmentSelected = false;
  bool _isOfficeSelected = false;

  bool _isCommercialSpaceSelected = false;
  bool _isEventSelected = false;
  bool _isHospitalSelected = false;
  bool _isIndustrialParkSelected = false;

  bool _isPostControl = false;
  bool _isCleaning = false;
  bool _isPlumbing = false;
  bool _iselectrician = false;

  Color _defaultContainerColor = Colors.white;
  Color _selectedContainerColor = Mycolor.maincolor;

  // Color _defaultImageColor = Colors.black;
  // Color _selectedImageColor = Colors.white;

  void _toggleHomeColor() {
    setState(() {
      _resetSelections();
      _isHomeSelected = true;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  void _toggleVillasColor() {
    setState(() {
      _resetSelections();
      _isVillasSelected = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  void _togglePostControlColor() {
    setState(() {
      _resetSelections();
      _isPostControl = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const PestControlMain(),
      );
    });
  }

  void _toggleCleaningColor() {
    setState(() {
      _resetSelections();
      _isCleaning = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const CleaningMainPage(),
      );
    });
  }

  void _togglePlumbingColor() {
    setState(() {
      _resetSelections();
      _isPlumbing = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const PlumingMainPage(),
      );
    });
  }

  void _toggleElectricianColor() {
    setState(() {
      _resetSelections();
      _iselectrician = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const ElectricianMainPage(),
      );
    });
  }

  void _toggleApartmentColor() {
    setState(() {
      _resetSelections();
      _isApartmentSelected = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  void _toggleOfficeColor() {
    setState(() {
      _resetSelections();
      _isOfficeSelected = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  void _toggleCommercialSpaceColor() {
    setState(() {
      _resetSelections();
      _isCommercialSpaceSelected = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  void _toggleEventColor() {
    setState(() {
      _resetSelections();
      _isEventSelected = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  void _toggleHospitalColor() {
    setState(() {
      _resetSelections();
      _isHospitalSelected = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  void _toggleIndustrialParkColor() {
    setState(() {
      _resetSelections();
      _isIndustrialParkSelected = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      showModalBottomSheet(
        context: context,
        builder: (context) => const Bottomsheet(),
      );
    });
  }

  void _resetSelections() {
    _isHomeSelected = false;
    _isVillasSelected = false;
    _isApartmentSelected = false;
    _isOfficeSelected = false;
    _isCommercialSpaceSelected = false;
    _isEventSelected = false;
    _isHospitalSelected = false;
    _isIndustrialParkSelected = false;
    _isPostControl = false;
    _isCleaning = false;
    _isPlumbing = false;
    _iselectrician = false;
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Do you really want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), // Stay in app
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); // Exit the app
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final myitems = [
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/slider-1.png',
            width: MediaQuery.of(context).size.width * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/SLIDER-2.png',
            width: MediaQuery.of(context).size.width * 0.9, fit: BoxFit.cover),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset('assets/images/slider3.png',
            width: MediaQuery.of(context).size.width * 0.9, fit: BoxFit.cover),
      ),
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey, // Assign the key to the Scaffold
        // backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.165),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(25),
                bottomEnd: Radius.circular(25),
              ),
              color: Mycolor.maincolor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 18, top: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Location()));
                          },
                          child: Icon(Icons.location_on, color: Colors.white)),
                      SizedBox(width: 5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Location()));
                          },
                          child: Text(
                            "$address2",
                            //------------------ widget.location,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: const Color.fromARGB(255, 122, 119, 119)
                              .withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Search...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color.fromARGB(252, 81, 186, 247),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage()));
                          },
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(251, 27, 171, 255),
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       DrawerHeader(
        //         decoration: BoxDecoration(
        //           color: Mycolor.maincolor,
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             CircleAvatar(
        //               radius: 50.0,
        //               backgroundImage: AssetImage('assets/images/MAN.png'),
        //             ),
        //             const SizedBox(height: 5.0), // Space between image and name
        //             Center(
        //               child: Text(
        //                 _usernameController.text.isNotEmpty
        //                     ? _usernameController.text
        //                     : 'Your Name', // Default if no name is stored
        //                 style: const TextStyle(
        //                   fontSize: 17.0,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.white,
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       // Other drawer items can go here
        //       // ListTile(
        //       //   leading: Icon(Icons.home),
        //       //   title: Text('Home'),
        //       //   onTap: () {
        //       //     // Do something when 'Home' is tapped
        //       //   },
        //       // ),
        //       // ListTile(
        //       //   leading: Icon(Icons.settings),
        //       //   title: Text('Settings'),
        //       //   onTap: () {
        //       //     // Do something when 'Settings' is tapped
        //       //   },
        //       // ),
        //     ],
        //   ),
        // ),

        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width *
                        0.57), // 77% of the screen width
                child: Text(
                  '#Special for you',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Mycolor.maincolor),
                ),
              ),
              SizedBox(height: 20),
              CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 190,
                    // autoPlayCurve: Curves.fastOutSlowIn,
                    // autoPlayAnimationDuration: const Duration(seconds: 2),
                    autoPlayInterval: const Duration(seconds: 5),
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    aspectRatio: 200,
                    onPageChanged: (index, reason) {
                      setState(() {
                        myCurrentIndex = index;
                      });
                    },
                  ),
                  items: myitems),
              SizedBox(height: 15),
              AnimatedSmoothIndicator(
                activeIndex: myCurrentIndex,
                count: myitems.length,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 5,
                  dotColor: const Color.fromARGB(255, 172, 171, 171),
                  activeDotColor: Mycolor.maincolor,
                  paintStyle: PaintingStyle.fill,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Mycolor.maincolor),
                            ),
                          ),
                          Spacer(), // Pushes the "See All" text to the right side
                          GestureDetector(
                            onTap: () {
                              // Handle the "see all" tap event
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: Mycolor.maincolor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 18), // Optional padding on the right side
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleHomeColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isHomeSelected
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/House.png',
                                        height: 40,
                                        width: 40,
                                        // color: _isHomeSelected
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleVillasColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isVillasSelected
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    borderRadius: BorderRadius.circular(10),
                                    // shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/villas.png',
                                        height: 37,
                                        width: 37,
                                        // color: _isVillasSelected
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Villas',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleApartmentColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isApartmentSelected
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/appartment.png',
                                        height: 37,
                                        width: 37,
                                        // color: _isApartmentSelected
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Appartment',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleOfficeColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 27),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: _isOfficeSelected
                                          ? _selectedContainerColor
                                          : _defaultContainerColor,
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 247, 245, 245),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/officee.png',
                                          height: 37,
                                          width: 37,
                                          // color: _isOfficeSelected
                                          //     ? _selectedImageColor
                                          //     : _defaultImageColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 27),
                                child: Text(
                                  'Office',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleCommercialSpaceColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isCommercialSpaceSelected
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/commercial space.png',
                                        height: 43,
                                        width: 43,
                                        // color: _isCommercialSpaceSelected
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Commercial',
                                style: TextStyle(fontSize: 11.5),
                              ),
                              Text(
                                'Space',
                                style: TextStyle(fontSize: 11.5),
                              )
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 8),
                              //   child: Text(
                              //     'Commercial',
                              //     style: TextStyle(fontSize: 12),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 8),
                              //   child: Text(
                              //     'Space',
                              //     style: TextStyle(fontSize: 12),
                              //   ),
                              // ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleEventColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isEventSelected
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/event.png',
                                        height: 43,
                                        width: 43,
                                        // color: _isEventSelected
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Event',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(''),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleHospitalColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isHospitalSelected
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/hospital.png',
                                        height: 43,
                                        width: 43,
                                        // color: _isHospitalSelected
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Hospital',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(''),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleIndustrialParkColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 27),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: _isIndustrialParkSelected
                                          ? _selectedContainerColor
                                          : _defaultContainerColor,
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 247, 245, 245),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/industrial.png',
                                          height: 43,
                                          width: 43,
                                          // color: _isIndustrialParkSelected
                                          //     ? _selectedImageColor
                                          //     : _defaultImageColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 27),
                                child: Text(
                                  'Industrial',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(''),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleCleaningColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isCleaning
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/cleaning.png',
                                        height: 40,
                                        width: 40,
                                        // color: _isCleaning
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Cleaning',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _togglePostControlColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isPostControl
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    borderRadius: BorderRadius.circular(10),
                                    // shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/pest control.png',
                                        height: 37,
                                        width: 37,
                                        // color: _isPostControl
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Pest Control',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _togglePlumbingColor,
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: _isPlumbing
                                        ? _selectedContainerColor
                                        : _defaultContainerColor,
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1.5,
                                      color: Color.fromARGB(255, 247, 245, 245),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/plumbing.png',
                                        height: 37,
                                        width: 37,
                                        // color: _isPlumbing
                                        //     ? _selectedImageColor
                                        //     : _defaultImageColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Plumbing',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: _toggleElectricianColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 27),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: _iselectrician
                                          ? _selectedContainerColor
                                          : _defaultContainerColor,
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1.5,
                                        color:
                                            Color.fromARGB(255, 247, 245, 245),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/electrician.png',
                                          height: 37,
                                          width: 37,
                                          // color: _iselectrician
                                          //     ? _selectedImageColor
                                          //     : _defaultImageColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 27),
                                child: Text(
                                  'Electrician',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "Popular Service",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Mycolor.maincolor),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/slider-1.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Floor Cleaning',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/SLIDER-2.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Carpet Cleaning',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/slider3.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Floor Cleaning',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/SLIDER-2.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Carpet Cleaning',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ],
          ),
        ),

        // bottomNavigationBar: Container(
        //   decoration: const BoxDecoration(
        //     color: Color.fromARGB(255, 76, 189, 255),
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(20.0),
        //       topRight: Radius.circular(20.0),
        //     ),
        //   ),
        //   child: MotionTabBar(
        //     initialSelectedTab: "Home",
        //     useSafeArea: true,
        //     labels: ["Product", "Home", "Booking History"],
        //     icons: [Icons.shopping_cart, Icons.home, Icons.history],
        //     tabSize: 52,
        //     tabBarHeight: 55,
        //     tabBarColor: Colors.transparent,
        //     textStyle: const TextStyle(
        //       fontSize: 15,
        //       color: Colors.white,
        //     ),
        //     tabIconColor: Colors.black,
        //     tabIconSize: 28.0,
        //     tabIconSelectedSize: 26.0,
        //     tabSelectedColor: Colors.white,
        //     tabIconSelectedColor: Colors.black,
        //     onTabItemSelected: (int value) {
        //       setState(() {
        //         myCurrentIndex = value;
        //         if (value == 0) {
        //           // Navigate to Profile page when "Profile" tab is tapped
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                   builder: (context) => ProductDetails()));
        //         }
        //       });
        //       setState(() {
        //         myCurrentIndex = value;
        //         if (value == 2) {
        //           // Navigate to Profile page when "Profile" tab is tapped
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => Bookinghistory()),
        //           );
        //         }
        //       });
        //     },
        //   ),
        // ),
      ),
    );
  }
}

//----------------------------------------------------------------------------------------------------//
// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   final String location;
//   const Home({super.key, required this.location});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(180),
//         child: Container(
//           height: 180,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(39),
//             color: Color.fromARGB(252, 81, 186, 247),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 18, right: 18, top: 56),
//             child: Row(
//               mainAxisAlignment:
//                   MainAxisAlignment.spaceBetween, // Space out the children
//               children: [
//                 // Left side
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       widget.location,
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Right side
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.notifications, color: Colors.white),
//                       onPressed: () {
//                         // Handle notification icon press
//                       },
//                     ),

//                     // IconButton(
//                     //   icon: Icon(Icons.settings, color: Colors.white),
//                     //   onPressed: () {
//                     //     // Handle settings icon press
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Center(
//         child: Text('Home Page Content'),
//       ),
//     );
//   }
// }
