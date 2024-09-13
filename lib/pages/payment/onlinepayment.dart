import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soapy_app/pages/customs/colors.dart';
import 'package:soapy_app/pages/customs/dailoguebox.dart';
import 'package:soapy_app/pages/demo.dart';
import 'package:soapy_app/pages/home.dart';

class Payment extends StatefulWidget {
  final double grandTotal;

  const Payment({super.key, required this.grandTotal});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  // Store values in SharedPreferences

  //first its no indicator show
  bool _isLoading = false;
// in this function say that only two second show the indicator
  void _handlePayment() async {
    setState(() {
      _isLoading = true; // Show loading spinner and overlay
    });

    await Future.delayed(Duration(seconds: 2)); // Simulate a 2-second delay

    // Hide the loading spinner and overlay
    // after go balck to false
    setState(() {
      _isLoading = false;
    });

    // Show the payment success dialog
    // already this fuction as been written just passing the data to that page
    DialogHelper.showSuccessDialog(
      context,
      title: "Payment Successful",
      message: "Your order has been booked successfully!",
      totalAmount: widget.grandTotal, // Pass the full total amount here
      onDone: () {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()), // Go to Home
        );
      },
    );
  }

  int _selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          'Payment Method',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildPaymentOption(
                  context,
                  1,
                  'Amazon Pay',
                  'assets/images/amazonpay.png',
                  imageWidth: 50,
                  imageHeight: 50,
                ),
                SizedBox(height: 16),
                _buildPaymentOption(
                  context,
                  2,
                  'Google Pay',
                  'assets/images/gpay.png',
                  imageWidth: 40,
                  imageHeight: 40,
                ),
                SizedBox(height: 16),
                _buildPaymentOption(
                  context,
                  3,
                  'Paytm',
                  'assets/images/paytm.png',
                  imageWidth: 45,
                  imageHeight: 45,
                ),
                SizedBox(height: 16),
                _buildPaymentOption(
                  context,
                  4,
                  'PhonePe',
                  'assets/images/phonepay.png',
                  imageWidth: 55,
                  imageHeight: 55,
                ),
                Spacer(),
                _buildPayButton(),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color:
                  Colors.black.withOpacity(0.5), // Semi-transparent background
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(
    BuildContext context,
    int value,
    String text,
    String imagePath, {
    required double imageWidth,
    required double imageHeight,
  }) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: _selectedPaymentMethod,
            activeColor: Colors.blue,
            onChanged: (int? newValue) {
              setState(() {
                _selectedPaymentMethod = newValue!;
              });
            },
          ),
          SizedBox(width: 20),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color:
                  _selectedPaymentMethod == value ? Colors.black : Colors.grey,
              fontWeight: _selectedPaymentMethod == value
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          Spacer(),
          Image.asset(
            imagePath,
            width: imageWidth,
            height: imageHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    bool isSelected = _selectedPaymentMethod != 0;

    return GestureDetector(
      onTap: () {
        // if (isSelected) {
        _handlePayment(); // Trigger payment logic with loading spinner
        //  }
        // else {
        // // Show a message that no payment method is selected
        // DialogHelper.showInfoDialog(
        //   context,
        //   title: "No Payment Method Selected",
        //   message: "Please select a payment method before proceeding.",
        // );
        // }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? Mycolor.maincolor : Colors.grey,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'Pay ₹${widget.grandTotal.toStringAsFixed(2)}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
