import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:soapy_app/pages/Location/location.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/username.dart';
//import 'home.dart';
// Ensure the correct import path

class Otp extends StatefulWidget {
  final String phone;
  final String countryCode;

  const Otp({Key? key, required this.countryCode, required this.phone})
      : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: const Color.fromARGB(255, 255, 255, 255),
      // borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Color.fromARGB(255, 223, 211, 211)),
      // boxShadow: [
      //   const BoxShadow(
      //     color: Color(0xffd9d9d9),
      //     spreadRadius: 5,
      //     blurRadius: 7,
      //     offset: Offset(0, 3),
      //   ),
      // ],
    ),
  );

  bool isPinComplete = false;
  String pin = "";

  String formatPhoneNumber(String phone, String countryCode) {
    if (phone.length < 3) {
      return '$countryCode $phone';
    }
    String maskedNumber =
        '*' * (phone.length - 2) + phone.substring(phone.length - 2);
    return '$countryCode $maskedNumber';
  }

  @override
  Widget build(BuildContext context) {
    String formattedPhoneNumber =
        formatPhoneNumber(widget.phone, widget.countryCode);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Login.jpg'), fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.11,
              ),
              Text(
                'Verifying your\nCode',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 120,
              ),
              Text(
                'Please type the verification code \n sent to $formattedPhoneNumber',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 38,
              ),
              Pinput(
                length: 4,
                obscureText: true,
                obscuringCharacter: '*',
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(
                      color: Mycolor.maincolor,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    pin = value;
                    isPinComplete = value.length == 4;
                    print("${pin}----------------------------------------");
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              GestureDetector(
                onTap: isPinComplete
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Username()),
                        );
                      }
                    : null,
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    color:
                        isPinComplete ? Mycolor.maincolor : Mycolor.maincolor,
                  ),
                  child: const Center(
                    child: Text(
                      'Verify',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't get code",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    'RECENT!',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 143, 0, 0)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
