// import 'package:dish_washer/pages/bottomsheet.dart';
// import 'package:dish_washer/api/api.dart';
// import 'package:dish_washer/api/api1.dart';
// import 'package:dish_washer/pages/bottomsheet.dart';
// import 'package:dish_washer/pages/login.dart';
// import 'package:dish_washer/pages/signin.dart';
// import 'package:dish_washer/pages/splash.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:dish_washer/pages/splash.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soapy_app/pages/Home%20Clean/deepclean.dart';
import 'package:soapy_app/pages/app_page.dart';
import 'package:soapy_app/pages/demo.dart';
import 'package:soapy_app/pages/home.dart';

import 'package:soapy_app/pages/reviewbottom.dart';

import 'package:soapy_app/pages/splash.dart';

// import 'package:test2/pages/splash.dart';

// import 'package:test2/pages/user.dart';
// import 'package:test1/pages/login1.dart';
// import 'package:test2/pages/splash.dart';
// import 'package:test1/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
