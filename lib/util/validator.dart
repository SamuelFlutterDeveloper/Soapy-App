// import 'dart:math';

class Validator {
  static String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a Mobile number';
    } else if ((!RegExp(r'^[0-9]{10}$').hasMatch(value))) {
      return "Please Enter a valid mobile number";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a Email Id';
    } else if ((!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value))) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? notEmpty(String? value) {
    if (value!.isEmpty) {
      return "Field cannot be empty";
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "Only alphabetic characters are allowed";
    }
    return null;
  }
}
